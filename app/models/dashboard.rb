class Dashboard < ApplicationRecord
  belongs_to :user
  belongs_to :dashboard_enum
  belongs_to :report

  has_many :report_dashboards, dependent: :destroy
  has_many :save_pivot_tables, through: :report_dashboards

  validates_presence_of :report_id, :user_id, :name
end
