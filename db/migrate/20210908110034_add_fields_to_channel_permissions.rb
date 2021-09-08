class AddFieldsToChannelPermissions < ActiveRecord::Migration[5.2]
  def change
    add_column :channel_permissions, :can_manage_multi_dataset_dashboard, :boolean, default: false
    add_column :channel_permissions, :can_manage_dashboard, :boolean, default: false
  end
end
