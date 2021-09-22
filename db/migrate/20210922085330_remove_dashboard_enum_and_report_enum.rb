class RemoveDashboardEnumAndReportEnum < ActiveRecord::Migration[5.2]
  def change
    remove_column :dashboards, :dashboard_enum_id
    remove_column :multi_data_set_dashboards, :dashboard_enum_id
    remove_column :reports, :report_enum_id
    remove_column :save_pivot_tables, :report_enum_id
  end
end
