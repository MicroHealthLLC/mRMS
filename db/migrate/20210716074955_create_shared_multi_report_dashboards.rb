class CreateSharedMultiReportDashboards < ActiveRecord::Migration[5.2]
  def change
    create_table :shared_multi_report_dashboards do |t|
      t.integer :pivot_table_id
      t.integer :multi_data_set_dashboard_id

      t.timestamps
    end
  end
end
