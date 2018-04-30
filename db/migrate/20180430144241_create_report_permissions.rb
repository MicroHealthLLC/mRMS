class CreateReportPermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :report_permissions do |t|
      t.integer :report_id
      t.integer :channel_id
      t.integer :user_id
      t.boolean :can_edit
      t.boolean :can_delete

      t.timestamps
    end
    add_index :report_permissions, :channel_id
    add_index :report_permissions, :report_id
    add_index :report_permissions, :user_id
  end
end
