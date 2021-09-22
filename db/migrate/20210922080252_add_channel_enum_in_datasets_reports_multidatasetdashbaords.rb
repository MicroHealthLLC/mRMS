class AddChannelEnumInDatasetsReportsMultidatasetdashbaords < ActiveRecord::Migration[5.2]
  def change
    add_column :multi_data_set_dashboards, :channel_enum_id, :integer
    add_column :save_pivot_tables, :channel_enum_id, :integer
    add_column :reports, :channel_enum_id, :integer
  end
end
