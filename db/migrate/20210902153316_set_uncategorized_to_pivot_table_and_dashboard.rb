class SetUncategorizedToPivotTableAndDashboard < ActiveRecord::Migration[5.2]
  def change
    report_enum = ReportEnum.find_by(name: 'Uncategorized')
    dashboard_enum = DashboardEnum.find_by(name: 'Uncategorized')

    SavePivotTable.all.each do|pivot|
      if pivot.report_enum.nil?
        pivot.update(report_enum_id: report_enum.id)
      end
    end

    Dashboard.all.each do|dashboard|
      if dashboard.dashboard_enum.nil?
        dashboard.update(dashboard_enum_id: dashboard_enum.id)
      end
    end
  end
end
