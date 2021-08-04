class AddOrderIndexToSharedMultiReportDashboards < ActiveRecord::Migration[5.2]
  def change
    add_column :shared_multi_report_dashboards, :order_index, :integer

    MultiDataSetDashboard.find_each do |dashboard|
      dashboard.shared_multi_report_dashboards.each_with_index do |pivot, index|
        pivot.update(order_index: index)
      end
    end
  end
end
