class AddIconToChannel < ActiveRecord::Migration[5.0]
  def change
    add_column :channels, :icon, :string
  end
end
