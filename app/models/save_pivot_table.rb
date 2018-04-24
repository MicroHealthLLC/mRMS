class SavePivotTable < ApplicationRecord
  validates_presence_of  :name, :report_id
  validates_uniqueness_of  :name, scope: [:report_id]
end
