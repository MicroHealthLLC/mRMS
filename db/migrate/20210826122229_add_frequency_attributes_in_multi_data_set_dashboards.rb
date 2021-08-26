class AddFrequencyAttributesInMultiDataSetDashboards < ActiveRecord::Migration[5.2]
  def change
    add_column :multi_data_set_dashboards, :frequently_count, :integer, default: 0
  end
end
