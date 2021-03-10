class AddOneDriveAccessTokenToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :onedrive_access_token, :text, default: nil
    add_column :users, :onedrive_refresh_token, :text, default: nil
  end
end
