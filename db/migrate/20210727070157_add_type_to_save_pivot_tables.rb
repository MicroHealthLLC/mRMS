class AddTypeToSavePivotTables < ActiveRecord::Migration[5.2]
  def change
    add_column :save_pivot_tables, :category_type, :integer
  end
end
