class CreateUserBlogs < ActiveRecord::Migration
  def change
    create_table :user_blogs do |t|
      t.integer :user_id
      t.integer :blog_id
      t.string :read_articles, array: true, default: []

      t.timestamps null: false
    end
  end
end
