class CreateChannelOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :channel_orders do |t|
      t.integer :channel_id
      t.integer :user_id
      t.integer :position, default: 0

      t.timestamps
    end
    add_index :channel_orders, :channel_id
    add_index :channel_orders, :user_id
  end
end
