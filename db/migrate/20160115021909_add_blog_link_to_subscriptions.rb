class AddBlogLinkToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :blog_link, :string
  end
end
