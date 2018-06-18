class NotificationMailer < ApplicationMailer

  helper MailerHelper
  def welcome_email(user, password= nil)
    @user = user
    @password = password
    mail(to: @user.email, subject: "Welcome to #{Setting['application_name']}")
  end

  def channel_created(user, channel)
    @user = user
    @channel = channel
    mail(to: @user.email, subject: "Channel #{@channel.name} was created")if @channel
  end

  def channel_updated(user, channel)
    @user = user
    @channel = channel
    mail(to: @user.email, subject: "Channel #{@channel.name} was updated") if @channel
  end


  def data_set_created(user, data_set)
    @user = user
    @data_set = data_set
    @channel = data_set.channel
    mail(to: @user.email, subject: "Data set in #{@channel.name} was created") if @data_set and @channel
  end

  def data_set_updated(user, data_set)
    @user = user
    @data_set = data_set
    @channel = data_set.channel
    mail(to: @user.email, subject: "Data set in #{@channel.name} was updated") if @data_set and @channel
  end

  def report_created(user, report)
    @user = user
    @report = report
    @data_set = @report.report
    @channel = @data_set.channel
    mail(to: @user.email, subject: "Report for #{@data_set.name} in #{@channel.name} was created")  if @data_set and @channel and @report
  end

  def report_updated(user, report)
    @user = user
    @report = report
    @data_set = @report.report
    @channel = @data_set.channel

    mail(to: @user.email, subject: "Report for #{@data_set.name} in #{@channel.name} was updated") if @data_set and @channel and @report
  end

end
