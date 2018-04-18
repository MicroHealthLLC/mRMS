class AddActiveToChannel < ActiveRecord::Migration[5.0]
  def change
    add_column :channels, :is_active, :boolean, default: true
  end
end
