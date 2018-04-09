class Report < ApplicationRecord
  belongs_to :channel
  has_many :shared_reports
  has_many :users, through: :shared_reports

  mount_uploader :document, ReportUploader

  after_create do
    if channel.is_personal?
      SharedReport.create(user_id: self.user_id, report_id: self.id)
    end
  end


end
