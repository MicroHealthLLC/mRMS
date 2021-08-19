class SetUncategorizedPivotTable < ActiveRecord::Migration[5.2]
  def change
    report_enum     = ReportEnum.find_or_create_by(name: 'Uncategorized')
    dashboard_enum  = DashboardEnum.find_or_create_by(name: 'Uncategorized')

    SavePivotTable.where(report_enum_id: nil).each do|pivot|
      pivot.update(report_enum_id: report_enum.id)
    end

    Dashboard.where(dashboard_enum_id: nil).each do|dashboard|
      dashboard.update(dashboard_enum_id: dashboard_enum.id)
    end
  end
end
