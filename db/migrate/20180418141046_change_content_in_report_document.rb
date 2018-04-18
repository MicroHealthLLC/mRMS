class ChangeContentInReportDocument < ActiveRecord::Migration[5.0]
  def change
    change_column :report_documents, :original_content, :mediumtext
    change_column :report_documents, :changed_content, :mediumtext
  end
end
