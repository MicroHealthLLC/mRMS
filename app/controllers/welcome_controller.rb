class WelcomeController < ApplicationController

  def index
    redirect_to new_user_session_path unless user_signed_in?

    @public_reports = params[:display_all_public].present? ? Report.public_channel_reports : Report.public_channel_reports.limit(3)
    @personal_reports = params[:display_all_personal].present? ? Report.personal_channel_reports : Report.personal_channel_reports.limit(3)
    @group_reports = params[:display_all_group].present? ? Report.group_channel_reports : Report.group_channel_reports.limit(3)

    @public_reports_count = Report.public_channel_reports.count
    @personal_reports_count = Report.personal_channel_reports.count
    @group_reports_count = Report.group_channel_reports.count

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
