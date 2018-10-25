class FixOrderChannel < ActiveRecord::Migration[5.0]
  def change
    User.all.each do |u|
      User.current = u
      scope  = []
      scope<< Channel.is_public
      scope<< Channel.for_user
      channels = scope.flatten.compact.map(&:id)
      channels << -1
      ChannelOrder.where.not(user_id: User.current.id, channel_id: channels).delete_all
    end
  end
end
