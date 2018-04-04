class EmailWorker
  include Sidekiq::Worker

  def perform(object_type, object_id)
    object = object_type.constantize.find_by_id(object_id)

    if object and object.respond_to?(:can_send_email?) and object.can_send_email? and object.email_notification_enabled?('create')
      UserMailer.send_notification(object).deliver_now
      c = self.try(:case)
      if c
        c.watchers.each do |watch|
          next if watch.user.nil?
          UserMailer.send_notification(object, watch.user).deliver_now
        end
      end
    end
  end
end
