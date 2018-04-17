class AddDescriptionToReport < ActiveRecord::Migration[5.0]
  def change
    add_column :reports, :description, :text
  end
end
