class ReportDashboard < ApplicationRecord
  belongs_to :dashboard
  belongs_to :save_pivot_table, foreign_key: 'pivot_table_id'

  validates_presence_of :pivot_table_id

  # validates_uniqueness_of :pivot_table_id, scope: [:dashboard_id]


  def self.safe_attributes
    [:id, :dashboard_id, :pivot_table_id, :_destroy]
  end
end
