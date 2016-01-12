class AddArticlesToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :articles, :string, array: true, default: []
  end
end
