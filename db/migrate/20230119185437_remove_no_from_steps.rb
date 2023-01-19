class RemoveNoFromSteps < ActiveRecord::Migration[6.1]
  def change
    remove_column :steps, :no, :integer
  end
end
