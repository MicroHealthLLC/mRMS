class Channel < ApplicationRecord
  has_many :channel_users
  has_many :reports

  has_many :users, through: :channel_users
  scope :personal, -> { where(is_personal: true)}
  scope :not_personal, -> { where(is_personal: false)}
  scope :is_public, -> { not_personal.where(is_public: true)}
  scope :for_user, -> { includes(:channel_users).not_personal.where(channel_users: {user_id: User.current.id}).where(is_public: false)}

  accepts_nested_attributes_for :channel_users, reject_if: :all_blank, allow_destroy: true

  after_create do
    ChannelUser.create(user_id: self.user_id, channel_id: self.id)
  end

  def self.market_place
    personal.where(user_id: User.current.id, name: 'Market Analyses' ).first_or_create
  end

  def self.segmented_market
    personal.where(user_id: User.current.id, name: 'Segmented Market' ).first_or_create
  end


  def self.safe_attributes
    [:user_id, :name, :is_public]
  end

  def visible_reports
    if is_personal?
      User.current.reports
    else
      reports
    end
  end

  def to_s
    name
  end
end