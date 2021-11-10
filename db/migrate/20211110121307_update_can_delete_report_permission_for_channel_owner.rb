class UpdateCanDeleteReportPermissionForChannelOwner < ActiveRecord::Migration[5.2]
  def change
    group_channels = Channel.where(option: 1)
    group_channels.each do |channel|
      channel_permission = channel.channel_permissions.find_by(user_id: channel.user_id)
      channel_permission.update(can_delete_pivot_table: true) if channel_permission
    end
  end
end
