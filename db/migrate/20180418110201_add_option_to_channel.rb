class AddOptionToChannel < ActiveRecord::Migration[5.0]
  def change
    add_column :channels, :option, :integer
    add_index :channels, :option
    Channel.unscoped.each do |channel|
      if channel.is_personal?
        channel.option = 3
      elsif channel.is_public?
        channel.option = 2
      else
        channel.option = 1
      end

      channel.save
    end
  end
end
