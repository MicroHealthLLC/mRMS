class CreateDashboards < ActiveRecord::Migration[5.2]
  def change
    create_table :dashboards do |t|
      t.integer :report_id
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end
end
