class RenameIsChackedColumnToNotifications < ActiveRecord::Migration[6.1]
  def change
    rename_column :notifications, :is_chacked, :is_checked
  end
end
