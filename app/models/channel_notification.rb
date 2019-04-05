class ChannelNotification < ApplicationRecord
  belongs_to :channel
  belongs_to :user

  REQUEST = 0
  LEFT = 1
end
