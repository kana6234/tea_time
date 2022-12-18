class AddTagToTeaName < ActiveRecord::Migration[6.1]
  def change
    change_column_default :tags, :tea_name, from: nil, to: false
  end
end
