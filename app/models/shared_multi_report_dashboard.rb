class SharedMultiReportDashboard < ApplicationRecord
  belongs_to :multi_data_set_dashboard
  belongs_to :save_pivot_table, foreign_key: 'pivot_table_id'

  validates_presence_of :pivot_table_id
end
