class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.integer :serves, null: false
      t.timestamps
    end
  end
end
