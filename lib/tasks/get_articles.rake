namespace :blog do
  desc "Get articles of blogs. eg:  rake blog:get_articles"
  task :get_articles => :environment do
    Blog.find_each do |blog|
      next unless blog.link

      body = HTTParty.get(blog.link).body rescue next
      doc = Nokogiri::HTML body

      article_nodes = doc.xpath('//article')
      nodes = article_nodes.any? ? article_nodes : doc.xpath('//li')

      articles = nodes.map do |node|
        article = {}
        node.xpath('.//a').each do |a_node|
          link = a_node.attributes['href'].to_s
          next if link.blank?

          if link.start_with?('/')
            article[:link] = URI.join(blog.link, link).to_s
            article[:title] = a_node.children.first.to_s
            break
          elsif link.start_with?(blog.link)
            article[:link] = link
            article[:title] = a_node.children.first.to_s
            break
          end
        end
        article.empty? ? nil : article
      end

      articles.compact!
      blog.update articles: articles if blog.articles != articles
    end

    puts 'Finish checking!'
  end
end
