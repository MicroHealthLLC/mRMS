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
  end

  def load_pivot_tables
    public_pivot_tables = SavePivotTable.where(report_id: @public_report_ids)
    personal_pivot_tables = SavePivotTable.where(report_id: @personal_report_ids)
    group_pivot_tables = SavePivotTable.where(report_id: @group_report_ids)
    all_pivot_tables = public_pivot_tables.or(personal_pivot_tables.or(group_pivot_tables))
    @all_reports = all_pivot_tables.order('frequently_count desc').first(6)
  end

  def load_dashboards
    public_dashboard = Dashboard.where(report_id: @public_report_ids)
    personal_dashboard = Dashboard.where(report_id: @personal_report_ids)
    group_dashboard = Dashboard.where(report_id: @group_report_ids)


    public_multi_dashboards = MultiDataSetDashboard.public_channel_multi_dashboard
    personal_multi_dashboards = MultiDataSetDashboard.personal_channel_multi_dashboard
    group_multi_dashboards = MultiDataSetDashboard.group_channel_multi_dashboard

    shared_dashboard_all = public_multi_dashboards.or(personal_multi_dashboards.or(group_multi_dashboards))

    dashboard_all = public_dashboard + personal_dashboard + group_dashboard + shared_dashboard_all
    dashboard_all = dashboard_all.uniq
    @dashboard_all = dashboard_all.sort_by(&:frequently_count).reverse.first(6)
  end

end
