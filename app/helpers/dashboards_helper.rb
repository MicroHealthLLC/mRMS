module DashboardsHelper

  def pluck_pivot_table(dashboard, params)
    pluckIds = []
    if params[:action] == "edit"
      dashboard.report_dashboards.order(:order_index).each do|dash|
        pluckIds.push(dash.pivot_table_id)
      end
    elsif params["pivot_table_ids"].present?
      pluckIds = JSON.parse(params["pivot_table_ids"])
    end
    return pluckIds
  end

  def load_pivot_tables_dashboards(dashboard)
    pivot_tables = []
    report_dashboards = dashboard.report_dashboards.includes(:save_pivot_table).order("order_index")
    report_dashboards.each do |report_dash|
      pivot_tables << report_dash.save_pivot_table
    end
    pivot_tables
  end

  def load_pivot_tables_shared_dashboards(dashboard)
    pivot_tables = []
    shared_multi_report_dashboards = dashboard.shared_multi_report_dashboards.includes(:save_pivot_table).order("order_index")
    shared_multi_report_dashboards.each do |shared_dash|
      pivot_tables << shared_dash.save_pivot_table
    end
    pivot_tables
  end

  def load_odd_record(array_record)
    data = array_record.each_with_index.map { |record, index| index.odd? ? record :  '' }
    data.reject { |d| d.blank? }
  end

  def load_even_record(array_record)
    data = array_record.each_with_index.map { |record, index| index.even? ? record :  '' }
    data.reject { |d| d.blank? }
  end
end
