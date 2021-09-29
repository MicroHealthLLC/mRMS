class RemoveDashboardEnumAndReportEnum < ActiveRecord::Migration[5.2]
  def change
    remove_column :dashboards, :dashboard_enum_id
    remove_column :save_pivot_tables, :report_enum_id
  end
end
