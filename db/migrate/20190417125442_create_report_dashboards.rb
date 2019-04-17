class CreateReportDashboards < ActiveRecord::Migration[5.2]
  def change
    create_table :report_dashboards do |t|
      t.integer :pivot_table_id
      t.integer :dashboard_id

      t.timestamps
    end
  end
end
