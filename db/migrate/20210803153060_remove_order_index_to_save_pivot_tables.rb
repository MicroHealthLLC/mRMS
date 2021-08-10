class RemoveOrderIndexToSavePivotTables < ActiveRecord::Migration[5.2]
  def change
    remove_column :save_pivot_tables, :order_index
  end
end
