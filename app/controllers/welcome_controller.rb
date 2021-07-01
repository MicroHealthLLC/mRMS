class WelcomeController < ApplicationController

  def index
    display_all_public = JSON.parse(params[:display_all_public]) rescue nil
    display_all_personal = JSON.parse(params[:display_all_personal]) rescue nil
    display_all_group = JSON.parse(params[:display_all_group]) rescue nil
    redirect_to new_user_session_path unless user_signed_in?
    reports = Report.by_frequently
    public_reports = []
    personal_reports = []
    group_reports = []
    reports.each do |report|
      if report.is_public_report?
        public_reports.push(report)
      elsif report.is_personal_report?
        personal_reports.push(report)
      elsif report.is_group_report?
        group_reports.push(report)
      end
    end
    @public_reports     = public_reports.first(3)
    @personal_reports   = personal_reports.first(3)
    @group_reports      = group_reports.first(3)
    if display_all_public
      @public_reports   =  public_reports
    elsif display_all_personal
      @personal_reports = personal_reports
    elsif display_all_group
      @group_reports    =    group_reports
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

end
# by_frequently
