class CreateAnswerLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :answer_likes do |t|
      t.integer :user_id, null: false
      t.integer :answer_id, null: false
      t.timestamps
    end
  end
end
