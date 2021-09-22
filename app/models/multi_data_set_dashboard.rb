class MultiDataSetDashboard < ApplicationRecord
  belongs_to :channel
  belongs_to :user
  belongs_to :channel_enum

  validates_presence_of :name

  has_many :shared_multi_report_dashboards, dependent: :destroy
  has_many :save_pivot_tables, through: :shared_multi_report_dashboards


  default_scope { order('frequently_count desc') }
  scope :public_channel_multi_dashboard, -> { where(channel_id: Channel.is_public.pluck(:id)) }
  scope :personal_channel_multi_dashboard, -> { where(channel_id: Channel.my_personal_channel.pluck(:id)) }
  scope :group_channel_multi_dashboard, -> { where(channel_id: Channel.for_user.pluck(:id)) }

  validates_presence_of :user_id
  validates_presence_of :channel_id
  before_save do
    self.name = self.name.strip unless self.name.nil?
  end
end
