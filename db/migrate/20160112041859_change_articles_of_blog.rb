class ChangeArticlesOfBlog < ActiveRecord::Migration
  def up
    remove_column :blogs, :articles
    add_column :blogs, :articles, :json, default: []
  end

  def down
    remove_column :blogs, :articles
    add_column :blogs, :articles, :string, array: true, default: []
  end
end
