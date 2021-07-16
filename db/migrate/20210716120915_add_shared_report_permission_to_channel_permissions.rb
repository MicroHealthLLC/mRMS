class AddSharedReportPermissionToChannelPermissions < ActiveRecord::Migration[5.2]
  def change
    add_column :channel_permissions, :can_shared_report_with_dashboard, :boolean, default: false
  end
end
