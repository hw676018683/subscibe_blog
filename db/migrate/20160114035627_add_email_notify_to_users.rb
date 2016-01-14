class AddEmailNotifyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email_notify, :boolean, default: true
  end
end
