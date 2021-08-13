class AddEnumTypeToDashboard < ActiveRecord::Migration[5.2]
  def change
    add_column :dashboards, :dashboard_enum_id, :integer
  end
end
