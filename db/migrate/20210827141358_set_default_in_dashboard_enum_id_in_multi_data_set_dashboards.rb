class SetDefaultInDashboardEnumIdInMultiDataSetDashboards < ActiveRecord::Migration[5.2]
  def change
    dashboard_enum  = DashboardEnum.find_by(name: 'Uncategorized')

    MultiDataSetDashboard.all.each do|dashboard|
      dashboard.update(dashboard_enum_id: dashboard_enum.id)
    end
  end
end
