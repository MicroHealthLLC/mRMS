class ReportWorker
  include Sidekiq::Worker

  def perform( object_id, action)
    p = SavePivotTable.find_by_id object_id
    if p
      if action == 1
        p.report.active_users.each do |user|
          NotificationMailer.report_created(user, p).deliver_now
        end
      else
        p.report.active_users.each do |user|
          NotificationMailer.report_updated(user, p).deliver_now
        end
      end
    end
  end
end
