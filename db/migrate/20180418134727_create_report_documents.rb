class CreateReportDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :report_documents do |t|
      t.integer :user_id
      t.string :file
      t.text :original_content
      t.text :changed_content
      t.integer :report_id

      t.timestamps
    end
    add_index :report_documents, :user_id
    add_index :report_documents, :report_id
  end
end
