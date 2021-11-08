class AddFieldToChannelPermission < ActiveRecord::Migration[5.2]
  def change
    add_column :channel_permissions, :can_delete_pivot_table, :boolean, default: false
  end
end
