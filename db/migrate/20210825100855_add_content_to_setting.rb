class AddContentToSetting < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :content, :string
  end
end
