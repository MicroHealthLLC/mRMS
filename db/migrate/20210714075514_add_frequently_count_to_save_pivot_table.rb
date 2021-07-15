class AddFrequentlyCountToSavePivotTable < ActiveRecord::Migration[5.2]
  def change
    add_column :save_pivot_tables, :frequently_count, :integer, default: 0
  end
end
