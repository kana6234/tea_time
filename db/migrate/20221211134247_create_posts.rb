class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.integer :postable_id, null: false
      t.string :postable_type, null: false
      t.string :title, null: false
      t.string :catchphrase, null: false
      t.text :introduction, null: false
      t.timestamps
    end
  end
end
