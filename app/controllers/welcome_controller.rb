class WelcomeController < ApplicationController

  def index
    display_all_public = JSON.parse(params[:display_all_public]) rescue nil
    display_all_personal = JSON.parse(params[:display_all_personal]) rescue nil
    display_all_group = JSON.parse(params[:display_all_group]) rescue nil
    redirect_to new_user_session_path unless user_signed_in?
    @personal_channels = Channel.my_personal_channel.includes(:reports).order(created_at: :desc).limit(3)
    @public_channels = Channel.is_public.includes(:reports).order(created_at: :desc).limit(3)
    @group_channels = Channel.for_user


    @public_channel_reports = channels_reports(@public_channels)
    @group_channel_reports = channels_reports(@group_channels)
    @personal_channel_reports = channels_reports(@personal_channels)

    @public_reports = @public_channel_reports.first(3)
    @group_reports = @group_channel_reports.first(3)
    @personal_reports = @personal_channel_reports.first(3)

    if display_all_public
      @public_reports = @public_channel_reports
    elsif display_all_personal
      @personal_reports = @personal_channel_reports
    elsif display_all_group
      @group_reports = @group_channel_reports
    end

    session[:appointment_store_id] = nil if User.current_user.can?(:manage_roles)
    if session[:employee_id]
      session[:appointment_store_id] = nil
      @employee = User.find session[:employee_id]
      session[:employee_id] = nil
      # flash[:notice]= "Logged Off from #{@employee.login}"
      redirect_to root_path
    end
    @setting = Setting.first || Setting.new
  end

  def onedriveredirect
  end

  private

  def channels_reports(channels)
    reports = []
    channels.each do |c|
      c.reports.each do |r|
        reports.push(r)
      end
    end
    reports
  end
end
