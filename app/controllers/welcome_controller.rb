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
    public_multi_dashboards = MultiDataSetDashboard.public_channel_multi_dashboard
    personal_multi_dashboards = MultiDataSetDashboard.personal_channel_multi_dashboard
    group_multi_dashboards = MultiDataSetDashboard.group_channel_multi_dashboard
    shared_dashboard_all = public_multi_dashboards + personal_multi_dashboards + group_multi_dashboards
    @shared_dashboard_all = shared_dashboard_all.first(3)
  end

  def load_pivot_tables
    public_pivot_tables = SavePivotTable.where(report_id: @public_report_ids)
    personal_pivot_tables = SavePivotTable.where(report_id: @personal_report_ids)
    group_pivot_tables = SavePivotTable.where(report_id: @group_report_ids)
    all_pivot_tables = public_pivot_tables.merge(personal_pivot_tables.merge(group_pivot_tables))
    @all_reports = all_pivot_tables.order('frequently_count desc').first(6)
  end

  def load_dashboards
    public_dashboard = Dashboard.where(report_id: @public_report_ids)
    personal_dashboard = Dashboard.where(report_id: @personal_report_ids)
    group_dashboard = Dashboard.where(report_id: @group_report_ids)
    dashboard_all = public_dashboard.merge(personal_dashboard.merge(group_dashboard))
    @dashboard_all = dashboard_all.order('frequently_count desc').first(3)
  end

end
