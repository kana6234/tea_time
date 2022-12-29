class CreateQuestionLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :question_likes do |t|
      t.integer :user_id, null: false
      t.integer :question_id, null: false
      t.timestamps
    end
  end
end
