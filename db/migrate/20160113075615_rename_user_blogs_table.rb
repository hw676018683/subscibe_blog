class RenameUserBlogsTable < ActiveRecord::Migration
  def change
    rename_table :user_blogs, :subscriptions
  end
end
