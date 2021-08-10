class RemovedCategoryTypeFromSavePivotTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :save_pivot_tables, :category_type
  end
end
