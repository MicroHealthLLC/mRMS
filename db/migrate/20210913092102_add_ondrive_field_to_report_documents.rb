class AddOndriveFieldToReportDocuments < ActiveRecord::Migration[5.2]
  def change
    add_column :report_documents, :onedrive_item_id, :string, default: ''
  end
end
