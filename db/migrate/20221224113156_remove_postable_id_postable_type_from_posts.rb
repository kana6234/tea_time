class RemovePostableIdPostableTypeFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :postable_id, :integer, null: false
    remove_column :posts, :postable_type, :string, null: false
  end
end
