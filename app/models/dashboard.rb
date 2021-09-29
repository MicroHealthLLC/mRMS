class Dashboard < ApplicationRecord
  belongs_to :user
  belongs_to :channel_enum
  belongs_to :report

  has_many :report_dashboards, dependent: :destroy
  has_many :save_pivot_tables, through: :report_dashboards

  validates_presence_of :report_id, :user_id, :name
  default_scope { order('frequently_count desc') }
  scope :default, -> { where(channel_enum_id: ChannelEnum.default.first.id)}

  before_save do
    self.name = self.name.strip unless self.name.nil?
  end
end
