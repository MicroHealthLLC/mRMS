class AddCreatedByToReport < ActiveRecord::Migration[5.0]
  def change
    add_column :reports, :created_by_id, :integer
    add_column :reports, :updated_by_id, :integer
  end
end
