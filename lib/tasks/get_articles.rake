require 'capybara/poltergeist'
require 'capybara/dsl'

namespace :blog do
  desc "Get articles of blogs. eg:  rake blog:get_articles"
  task :get_articles => :environment do
    crawler = PoltergeistCrawler.new

    Blog.find_each do |blog|
      next unless blog.link
      begin
        blog.update_columns last_crawl_at: Time.now
        articles = ArticlesCrawler.new(blog.link, crawler).run
      rescue Exception => e
        Rails.logger.info e.inspect
        next
      end
      blog.update articles: articles if blog.articles != articles
    end

    puts 'Finish checking!'
  end
end

class ArticlesCrawler
  DATE_REG = /\d{4}[-\/\.]\d{1,2}[-\/\.]\d{1,2}/
  TITLE_REG = /class="[\w\s-]*title[\w\s-]*"/
  H_REG = /<h.*<\/h/
  POST_REG= /class="[\w\s-]*post[\w\s-]*"/
  NODE_NAME_REG = /(div|article|li|h\d|dl|tr|section)/

  def initialize blog_link, crawler
    @blog_link = blog_link
    @uri = URI.parse blog_link
    @host = "#{@uri.scheme}://#{@uri.host}"
    @root_path = "#{@uri.scheme}://#{@uri.host}/"
    @crawler = crawler
  end

  def run
    html = @crawler.crawl @blog_link
    if !html.valid_encoding?
      html = html.encode("UTF-16be", :invalid=>:replace, :replace=>"?").encode('UTF-8')
    end
    extract_articles Nokogiri::HTML(html).at_xpath('//body')
  end

  private

  def extract_articles html_body
    list_nodes = get_list_nodes html_body

    articles = list_nodes.map do |node|
      article = {}
      node.xpath('.//a').each do |a_node|
        link = a_node.attributes['href'].to_s
        next if link.blank?
        next if link == @root_path
        next if link == @blog_link
        next if link.start_with?('javascript')

        link = link.start_with?('/') ? "#{@host}#{link}" : link
        h_node = node.at_xpath('.//h1 | .//h2 | .//h3 | .//h4 | .//h5 ')
        title = h_node ? h_node.inner_text : a_node.children.first.inner_text
        article[:link] = link
        article[:title] = format_title(title)
        break
      end
      article.empty? ? nil : article
    end

    articles.compact.uniq
  end

  def get_list_nodes html_body
    # article_nodes = html_body.xpath('.//article')
    # return article_nodes if article_nodes.any?

    hash_array = get_nodes_map html_body
    find_most_possible_nodes(hash_array)
  end

  def get_nodes_map node
    hash_array = []
    hash = Hash.new { |hash, key| hash[key]  = [] }

    node.children.each do |child|
      next unless child.name.match NODE_NAME_REG
      next unless child.xpath('.//a').any?

      attributes = child.attributes.slice 'id', 'class'
      attributes = attributes.delete_if { |key, value| key == 'id' && value.value.match(/\d/) }
      key = "#{child.name}-#{attributes.values.join('-')}"
      hash[key] = hash[key] << child
    end
    hash.reject! do |key, value|
      value.count < 2
    end
    hash_array << hash if hash.any?

    node.children.each do |child|
      hash_array += get_nodes_map(child)
    end
    hash_array
  end

  def find_most_possible_nodes hash_array
    #date
    #css: 'title' class
    #html: h node
    #css: 'post' class
    ordered_reg = [DATE_REG, TITLE_REG, H_REG, POST_REG]

    result = ordered_reg.each do |reg|
      hash_array = filter_nodes hash_array, reg
      break hash_array[0].values.first if hash_array.count == 1
    end

    if result == ordered_reg
      hash_array.map(&:values).flatten
    else
      result
    end
  end

  def filter_nodes hash_array, reg
    include_nodes = hash_array.select do |hash|
      hash.values.any? do |nodes|
        nodes.all? { |node| node.to_html.match reg }
      end
    end

    include_nodes.any? ? include_nodes : hash_array
  end

  def format_title title
    title.squeeze.strip
  end
end

class PoltergeistCrawler
  include Capybara::DSL

  def initialize
    Capybara.register_driver :poltergeist_crawler do |app|
      Capybara::Poltergeist::Driver.new(app, {
        :js_errors => false,
        :inspector => false,
        phantomjs_logger: open('/dev/null') # if you don't care about JS errors/console.logs
      })
    end
    Capybara.default_max_wait_time = 10
    Capybara.run_server = false
    Capybara.default_driver = :poltergeist_crawler
    page.driver.headers = {
      "User-Agent" => "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:22.0) Gecko/20100101 Firefox/22.0"
    }
  end

  def crawl blog_link
    visit blog_link
    page.body
  end
end
