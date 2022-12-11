class CreateBusinessHours < ActiveRecord::Migration[6.1]
  def change
    create_table :business_hours do |t|
      t.integer :shop_id, null: false
      t.time :start_at, null: false
      t.time :finish_at, null: false
      t.timestamps
    end
  end
end
