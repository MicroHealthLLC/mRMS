class Dashboard < ApplicationRecord
  belongs_to :user
  belongs_to :report

  has_many :report_dashboards, dependent: :destroy
  has_many :save_pivot_tables, through: :report_dashboards
  accepts_nested_attributes_for :report_dashboards, reject_if: :all_blank, allow_destroy: true


  validates_presence_of :report_id, :user_id, :name


end
