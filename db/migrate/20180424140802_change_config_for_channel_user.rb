class ChangeConfigForChannelUser < ActiveRecord::Migration[5.0]
  def change
    if defined?(ChannelUser)
      ChannelUser.all.each do |channel_user|
        ChannelPermission.create(channel_id: channel_user.channel_id, user_id: channel_user.user_id)
      end
    end
  end
end
