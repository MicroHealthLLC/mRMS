class AddChannelIdToReport < ActiveRecord::Migration[5.0]
  def change
    add_column :reports, :channel_id, :integer
  end
end
