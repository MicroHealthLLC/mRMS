class Channel < ApplicationRecord
  has_many :channel_users
  has_many :users, through: :channel_users
  scope :is_public, -> { where(is_public: true)}
  scope :for_user, -> { includes(:channel_users).where(channel_users: {user_id: User.current.id}).where(is_public: false)}

  accepts_nested_attributes_for :channel_users, reject_if: :all_blank, allow_destroy: true

  after_create do
    ChannelUser.create(user_id: self.user_id, channel_id: self.id)
  end


  def self.safe_attributes
    [:user_id, :name, :is_public, ChannelUser]
  end
end
