class AddBlogNameToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :blog_name, :string
  end
end
