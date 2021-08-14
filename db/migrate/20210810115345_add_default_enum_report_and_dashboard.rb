class AddDefaultEnumReportAndDashboard < ActiveRecord::Migration[5.2]
  def change
    dashboard_enum  = DashboardEnum.find_or_create_by(name: 'Default', active: true)
    report_enum     = ReportEnum.find_or_create_by(name: 'Default', active: true)

    SavePivotTable.all.each do|pivot|
      pivot.report_enum_id = report_enum.id
      pivot.save
    end

    Dashboard.all.each do|dashboard|
      dashboard.dashboard_enum_id = dashboard_enum.id
      dashboard.save
    end
  end
end
