class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :post_id
      t.integer :post_comment_id
      t.integer :question_id
      t.integer :answer_id
      t.integer :action, null: false
      t.boolean :is_chacked, null: false, default: "false"
      t.timestamps
    end

    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
    add_index :notifications, :post_id
    add_index :notifications, :post_comment_id
    add_index :notifications, :question_id
    add_index :notifications, :answer_id
  end
end
