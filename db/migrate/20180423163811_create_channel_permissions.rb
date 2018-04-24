class CreateChannelPermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :channel_permissions do |t|
      t.integer :user_id
      t.integer :channel_id
      t.boolean :can_view, default: false
      t.boolean :can_edit, default: false

      t.boolean :can_add_report, default: false
      t.boolean :can_delete_report, default: false
      t.boolean :can_add_users, default: false

      t.timestamps
    end
    add_index :channel_permissions, :user_id
    add_index :channel_permissions, :channel_id
  end
end
