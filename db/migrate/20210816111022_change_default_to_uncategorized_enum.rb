class ChangeDefaultToUncategorizedEnum < ActiveRecord::Migration[5.2]
  def change
    ReportEnum.all.each do|report_enum|
      if report_enum.name == "Default"
        report_enum.name = "uncategorized"
        report_enum.save
      end
    end

    DashboardEnum.all.each do|dashbord_enum|
      if dashbord_enum.name == "Default"
        dashbord_enum.name = "uncategorized"
        dashbord_enum.save
      end
    end
  end
end
