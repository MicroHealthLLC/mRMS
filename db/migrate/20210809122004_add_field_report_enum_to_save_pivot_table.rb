class AddFieldReportEnumToSavePivotTable < ActiveRecord::Migration[5.2]
  def change
    add_column :save_pivot_tables, :report_enum_id, :integer
  end
end
