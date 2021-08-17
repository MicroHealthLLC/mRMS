class ChangeDefaultToUncategorizedEnum < ActiveRecord::Migration[5.2]
  def change
    ReportEnum.find_by_name("Default")&.destroy!
    DashboardEnum.find_by_name("Default")&.destroy!

    ReportEnum.find_or_create_by(name: 'Uncategorized', active: true, is_default: true)
    DashboardEnum.find_or_create_by(name: 'Uncategorized', active: true, is_default: true)
  end
end
