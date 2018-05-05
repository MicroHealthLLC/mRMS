class AddCanDownloadToChannelPermission < ActiveRecord::Migration[5.0]
  def change
    add_column :channel_permissions, :can_download, :boolean, default: false
  end
end
