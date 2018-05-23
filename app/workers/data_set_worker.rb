class DataSetWorker
  include Sidekiq::Worker

  def perform( object_id, action)
    r = Report.find_by_id object_id
    if r
      if action == 1
        r.active_users.each do |user|
          NotificationMailer.data_set_created(user, r).deliver_now
        end
      else
        r.active_users.each do |user|
          NotificationMailer.data_set_updated(user, r).deliver_now
        end
      end
    end
  end
end
