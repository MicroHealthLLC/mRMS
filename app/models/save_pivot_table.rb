class SavePivotTable < ApplicationRecord

  audited except: [:created_at, :updated_at, :content]

  validates_presence_of  :name, :report_id
  validates_uniqueness_of  :name, scope: [:report_id]

  belongs_to :user, optional: true
  belongs_to :report, optional: true
  delegate :channel, to: :report


  after_create do
    ReportWorker.perform_in(1.second,  self.id)
  end

  after_update do
    report.active_users.each do |user|
      NotificationMailer.report_updated(user, self).deliver_later
    end
  end

end
