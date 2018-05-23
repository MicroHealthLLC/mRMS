class SavePivotTable < ApplicationRecord

  audited except: [:created_at, :updated_at]

  validates_presence_of  :name, :report_id
  validates_uniqueness_of  :name, scope: [:report_id]

  belongs_to :user, optional: true
  belongs_to :report, optional: true
  delegate :channel, to: :report


  after_create do
    report.active_users.each do |user|
      NotificationMailer.report_created(user, self).deliver_later
    end
  end

  after_update do
    report.active_users.each do |user|
      NotificationMailer.report_updated(user, self).deliver_later
    end
  end

end
