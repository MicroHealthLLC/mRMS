class ChannelPermission < ApplicationRecord
  belongs_to :user
  belongs_to :channel

  validates_presence_of :user_id, :channel_id
  validates_uniqueness_of :user_id, scope: :channel_id
end
