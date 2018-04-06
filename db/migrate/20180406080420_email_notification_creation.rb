class EmailNotificationCreation < ActiveRecord::Migration[5.0]
  def change
    emails_type = ["Report", "News"]
    emails_type.each do |e|
      EmailNotification.create(name: e, email_type: 'create')
      EmailNotification.create(name: e, email_type: 'update')
    end
  end
end
