class AddCanViewReportToChannelPermission < ActiveRecord::Migration[5.0]
  def change
    add_column :channel_permissions, :can_view_report, :boolean, default: false
   begin
     ChannelPermission.update_all('can_view_report = can_view')
   rescue

   end
  end
end
