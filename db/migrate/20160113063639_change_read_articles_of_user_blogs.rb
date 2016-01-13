class ChangeReadArticlesOfUserBlogs < ActiveRecord::Migration
  def up
    remove_column :user_blogs, :read_articles
    add_column :user_blogs, :read_articles, :json, default: []
  end

  def down
    remove_column :user_blogs, :read_articles
    add_column :user_blogs, :read_articles, :string, array: true, default: []
  end
end
