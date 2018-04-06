class CreateChannels < ActiveRecord::Migration[5.0]
  def change
    create_table :channels do |t|
      t.string :name
      t.boolean :is_public, default: false
      t.integer :user_id

      t.timestamps
    end
    add_index :channels, :user_id
  end
end
