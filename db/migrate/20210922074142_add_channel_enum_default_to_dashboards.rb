class AddChannelEnumDefaultToDashboards < ActiveRecord::Migration[5.2]
  def change
    channel_enum = ChannelEnum.find_or_create_by(name:"Uncategorized")
    Dashboard.all.each do|dashboard|
      if dashboard.channel_enum.nil?
        dashboard.update(channel_enum_id: channel_enum.id)
      end
    end
  end
end
