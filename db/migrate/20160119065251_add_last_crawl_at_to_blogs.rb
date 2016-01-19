class AddLastCrawlAtToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :last_crawl_at, :datetime
  end
end
