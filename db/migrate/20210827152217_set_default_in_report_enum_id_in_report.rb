class SetDefaultInReportEnumIdInReport < ActiveRecord::Migration[5.2]
  def change
    report_enum  = ReportEnum.find_by(name: 'uncategorized')

    Report.all.each do|report|
      report.update(report_enum_id: report_enum.id)
    end
  end
end
