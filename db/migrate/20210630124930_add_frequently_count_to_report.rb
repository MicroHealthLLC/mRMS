class AddFrequentlyCountToReport < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :frequently_count, :integer, default: 0
  end
end
