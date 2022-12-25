class AddPostIdToRecipesShopsItems < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :post_id, :integer, null: false
    add_column :shops, :post_id, :integer, null: false
    add_column :items, :post_id, :integer, null: false
  end
end
