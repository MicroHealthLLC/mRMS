class AddReportEnumIdInDataSets < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :report_enum_id, :integer
  end
end
