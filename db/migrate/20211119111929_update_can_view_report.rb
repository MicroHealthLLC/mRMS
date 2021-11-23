class UpdateCanViewReport < ActiveRecord::Migration[5.2]
  def change
    change_column :channel_permissions, :can_view, :boolean, default: true
    change_column :channel_permissions, :can_view_report, :boolean, default: true

    channel_permissions = ChannelPermission.all
    channel_permissions.each do |channel_permission|
      channel_permission.update(can_view: true)
      channel_permission.update(can_view_report: true)
    end
  end
end
