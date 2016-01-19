class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :blog_id, index: true
      t.text :content

      t.timestamps null: false
    end
  end
end
