class AddDescriptionToChannel < ActiveRecord::Migration[5.0]
  def change
    add_column :channels, :description, :text
  end
end
