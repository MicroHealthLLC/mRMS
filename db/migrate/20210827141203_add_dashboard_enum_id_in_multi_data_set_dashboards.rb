class AddDashboardEnumIdInMultiDataSetDashboards < ActiveRecord::Migration[5.2]
  def change
    add_column :multi_data_set_dashboards, :dashboard_enum_id, :integer
  end
end
