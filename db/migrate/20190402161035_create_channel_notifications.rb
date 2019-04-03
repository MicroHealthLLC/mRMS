class CreateChannelNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :channel_notifications do |t|
      t.integer :user_id
      t.integer :channel_id
      t.integer :notification_type
      t.integer :seen, default: false

      t.timestamps
    end
    add_index :channel_notifications, :user_id
    add_index :channel_notifications, :channel_id
  end
end
