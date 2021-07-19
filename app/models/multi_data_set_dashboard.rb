class MultiDataSetDashboard < ApplicationRecord
  belongs_to :channel
  belongs_to :user
  validates_presence_of :name

  has_many :shared_multi_report_dashboards, dependent: :destroy
  has_many :save_pivot_tables, through: :shared_multi_report_dashboards

  validates_presence_of :user_id
  validates_presence_of :channel_id
end
