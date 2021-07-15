class AddFrequentlyCountToDashboard < ActiveRecord::Migration[5.2]
  def change
    add_column :dashboards, :frequently_count, :integer, default: 0
  end
end
