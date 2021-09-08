class SetAdminOnFirstInGroupChannelPermissions < ActiveRecord::Migration[5.2]
  def change
    Channel.all.each do|channel|
      permission = channel.channel_permissions.where(user_id: channel.user_id, channel_id: channel.id).first_or_initialize
      permission.can_view = true
      permission.can_edit = true
      permission.can_add_report = true
      permission.can_delete_report = true
      permission.can_add_users = true
      permission.can_download = true
      permission.can_view_report = true
      permission.can_manage_dashboard = true
      permission.can_view_report = true
      permission.can_manage_multi_dataset_dashboard = true
      permission.save!
    end
  end
end
