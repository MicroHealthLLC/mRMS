class MultiDataSetDashboard < ApplicationRecord
  belongs_to :channel
  belongs_to :user
  validates_presence_of :name

  has_many :shared_multi_report_dashboards, dependent: :destroy
  has_many :save_pivot_tables, through: :shared_multi_report_dashboards

  scope :public_channel_multi_dashboard, -> { where(channel_id: Channel.is_public.pluck(:id)) }
  scope :personal_channel_multi_dashboard, -> { where(channel_id: Channel.my_personal_channel.pluck(:id)) }
  scope :group_channel_multi_dashboard, -> { where(channel_id: Channel.for_shared_users.pluck(:id)) }

  validates_presence_of :user_id
  validates_presence_of :channel_id
end
