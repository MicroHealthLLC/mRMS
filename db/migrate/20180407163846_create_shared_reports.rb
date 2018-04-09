class CreateSharedReports < ActiveRecord::Migration[5.0]
  def change
    create_table :shared_reports do |t|
      t.integer :user_id
      t.integer :report_id

      t.timestamps
    end
    add_index :shared_reports, :user_id
    add_index :shared_reports, :report_id
  end
end
