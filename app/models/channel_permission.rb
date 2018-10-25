class ChannelPermission < ApplicationRecord
  belongs_to :user
  belongs_to :channel

  validates_presence_of :user_id, :channel_id
  validates_uniqueness_of :user_id, scope: :channel_id

  after_save do
    unless self.can_view?
      user.channel_orders.where(channel_id: channel_id).delete_all
    end
  end

  before_destroy do
    user.channel_orders.where(channel_id: channel_id).delete_all
  end
end
