class AddCreatedByToChannel < ActiveRecord::Migration[5.0]
  def change
    add_column :channels, :created_by_id, :integer
    add_column :channels, :updated_by_id, :integer
  end
end
