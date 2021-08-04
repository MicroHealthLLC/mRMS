class AddOrderIndexToReportDashboards < ActiveRecord::Migration[5.2]
  def change
    add_column :report_dashboards, :order_index, :integer

    Dashboard.find_each do |dashboard|
      dashboard.report_dashboards.each_with_index do |pivot, index|
        pivot.update(order_index: index)
      end
    end
  end
end
