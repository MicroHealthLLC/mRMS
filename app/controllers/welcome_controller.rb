class WelcomeController < ApplicationController

  def index
    redirect_to new_user_session_path unless user_signed_in?

    @public_report_ids = Report.public_channel_reports.pluck(:id)
    @personal_report_ids = Report.personal_channel_reports.pluck(:id)
    @group_report_ids = Report.group_channel_reports.pluck(:id)

    load_pivot_tables
    load_dashboards
    load_multi_shared_dashboard_data
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

  def load_multi_shared_dashboard_data
    disp_more = params[:display_more]
    public_multi_dashboards          = MultiDataSetDashboard.public_channel_multi_dashboard
    personal_multi_dashboards        = MultiDataSetDashboard.personal_channel_multi_dashboard
    group_multi_dashboards           = MultiDataSetDashboard.group_channel_multi_dashboard

    @public_shared_dashboard         = (disp_more == "display_all_public_shared_dashboard") ? public_multi_dashboards : public_multi_dashboards.first(3)
    @personal_shared_dashboard       = (disp_more == "display_all_personal_shared_dashboard") ? personal_multi_dashboards : personal_multi_dashboards.first(3)
    @group_shared_dashboard          = (disp_more == "display_all_group_shared_dashboard") ? group_multi_dashboards : group_multi_dashboards.first(3)

    @public_shared_dashboard_count   = public_multi_dashboards.count
    @personal_shared_dashboard_count = personal_multi_dashboards.count
    @group_dashboard_shared_count    = group_multi_dashboards.count
  end

  def load_pivot_tables
    public_pivot_tables = SavePivotTable.where(report_id: @public_report_ids)
    personal_pivot_tables = SavePivotTable.where(report_id: @personal_report_ids)
    group_pivot_tables = SavePivotTable.where(report_id: @group_report_ids)

    disp_more = params[:display_more]

    @public_reports = (disp_more == "display_all_public") ? public_pivot_tables : public_pivot_tables.first(3)
    @personal_reports = (disp_more == "display_all_personal") ? personal_pivot_tables : personal_pivot_tables.first(3)
    @group_reports = (disp_more == "display_all_group") ? group_pivot_tables : group_pivot_tables.first(3)

    @public_reports_count =  public_pivot_tables.count
    @personal_reports_count = personal_pivot_tables.count
    @group_reports_count = group_pivot_tables.count
  end

  def load_dashboards
    disp_more = params[:display_more]
    public_dashboard = Dashboard.where(report_id: @public_report_ids)
    personal_dashboard = Dashboard.where(report_id: @personal_report_ids)
    group_dashboard_reports = Dashboard.where(report_id: @group_report_ids)
    @public_dashboard = (disp_more == "display_all_public_dashboard") ? public_dashboard : public_dashboard.first(3)
    @personal_dashboard = (disp_more == "display_all_personal_dashboard") ? personal_dashboard : personal_dashboard.first(3)
    @group_dashboard = (disp_more == "display_all_group_dashboard") ? group_dashboard_reports : group_dashboard_reports.first(3)

    @public_dashboard_count = public_dashboard.count
    @personal_dashboard_count = personal_dashboard.count
    @group_dashboard_count = group_dashboard_reports.count
  end

end
