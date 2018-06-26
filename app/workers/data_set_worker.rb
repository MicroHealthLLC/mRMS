class DataSetWorker
  include Sidekiq::Worker

  def perform( object_id, action)
    data_set = Report.find_by_id object_id
    if data_set
      if action == 1
        data_set.active_users.each do |user|
          NotificationMailer.data_set_created(user, data_set).deliver_now
        end
      else
        data_set.active_users.each do |user|
          NotificationMailer.data_set_updated(user, data_set).deliver_now
        end
      end
    end
  end
end
