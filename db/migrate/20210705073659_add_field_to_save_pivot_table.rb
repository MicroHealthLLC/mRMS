class AddFieldToSavePivotTable < ActiveRecord::Migration[5.2]
  def change
    add_column :save_pivot_tables, :order_index, :integer
  end
end
