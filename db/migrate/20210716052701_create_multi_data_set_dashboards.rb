class CreateMultiDataSetDashboards < ActiveRecord::Migration[5.2]
  def change
    create_table :multi_data_set_dashboards do |t|
      t.integer :channel_id
      t.integer :user_id
      t.string :name

      t.timestamps
    end
  end
end
