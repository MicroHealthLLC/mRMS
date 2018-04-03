class UserMailer < ApplicationMailer

  helper MailerHelper
  def welcome_email(user, password= nil)
    @user = user
    @password = password
    mail(to: @user.email, subject: "Welcome to #{Setting['application_name']}")
  end

  def account_activated(user)
    @user = user
    mail(to: @user.email, subject: 'Account activated')
  end

  def new_notification(object)
    @user = object.user
    @object = object
    mail(to: @user.email, subject: "New ##{@object.id}")
  end

  def send_notification(object, user = object.user)
    @user   = user
    @object = object
    @template = object.email_template(user)
    mail(to: @user.email, subject: "#{@object.to_s}")
  end

  def send_update_notification(object, audit, user = object.user)
    @user   = user
    @object = object
    @audit = audit
    @template = object.email_template(user)
    mail(to: @user.email, subject: "#{@object.to_s}")
  end
end
