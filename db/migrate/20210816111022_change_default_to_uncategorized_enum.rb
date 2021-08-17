class ChangeDefaultToUncategorizedEnum < ActiveRecord::Migration[5.2]
  def change
    ReportEnum.all.each do|report_enum|
      if report_enum.name.capitalize == "Default"
        report_enum.name        = "Uncategorized"
        report_enum.is_default  = true
        report_enum.save
      end
    end

    DashboardEnum.all.each do|dashbord_enum|
      if dashbord_enum.name.capitalize == "Default"
        dashbord_enum.name        = "Uncategorized"
        dashbord_enum.is_default  = true
        dashbord_enum.save
      end
    end
  end
end
