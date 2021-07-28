class WelcomeController < ApplicationController

  def index
    redirect_to new_user_session_path unless user_signed_in?

    public_report_ids = Report.public_channel_reports.pluck(:id)
    personal_report_ids = Report.personal_channel_reports.pluck(:id)
    group_report_ids = Report.group_channel_reports.pluck(:id)

    public_pivot_tables = SavePivotTable.where(report_id: public_report_ids)
    personal_pivot_tables = SavePivotTable.where(report_id: personal_report_ids)
    group_pivot_tables = SavePivotTable.where(report_id: group_report_ids)

    public_dashboard = Dashboard.where(report_id: public_report_ids)
    personal_dashboard = Dashboard.where(report_id: personal_report_ids)
    group_dashboard_reports = Dashboard.where(report_id: group_report_ids)

    @public_reports = params[:display_all_public].present? ? public_pivot_tables : public_pivot_tables.first(3)
    @personal_reports = params[:display_all_personal].present? ? personal_pivot_tables : personal_pivot_tables.first(3)
    @group_reports = params[:display_all_group].present? ? group_pivot_tables : group_pivot_tables.first(3)

    @public_dashboard = params[:display_all_public_dashboard].present? ? public_dashboard : public_dashboard.first(3)
    @personal_dashboard = params[:display_all_personal_dashboard].present? ? personal_dashboard : personal_dashboard.first(3)
    @group_dashboard = params[:display_all_group_dashboard].present? ? group_dashboard_reports : group_dashboard_reports.first(3)

    @public_reports_count =  public_pivot_tables.count
    @personal_reports_count = personal_pivot_tables.count
    @group_reports_count = group_pivot_tables.count

    @public_dashboard_count = public_dashboard.count
    @personal_dashboard_count = personal_dashboard.count
    @group_dashboard_count = group_dashboard_reports.count

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
