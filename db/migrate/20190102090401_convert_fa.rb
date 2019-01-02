class ConvertFa < ActiveRecord::Migration[5.0]
  def change
    Channel.all.each do |channel|
      channel.update_columns(icon: "fa #{channel.icon}")
    end
  end
end
