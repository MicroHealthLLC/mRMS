module MultiDataSetDashboardsHelper

  def pluck_pivot_table_ids(multi_dashboard, params)
    pluckIds = []
    if params[:action] == "edit"
      multi_dashboard.shared_multi_report_dashboards.order(:order_index).each do|dash|
        pluckIds.push(dash.pivot_table_id)
      end
    elsif params["pivot_table_ids"].present?
      pluckIds = JSON.parse(params["pivot_table_ids"])
    end
    return pluckIds
  end
end
