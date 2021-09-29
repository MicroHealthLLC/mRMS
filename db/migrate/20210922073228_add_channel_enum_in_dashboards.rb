class AddChannelEnumInDashboards < ActiveRecord::Migration[5.2]
  def change
    add_column :dashboards, :channel_enum_id, :integer
  end
end
