class AddPersonalChannelToChannel < ActiveRecord::Migration[5.0]
  def change
    add_column :channels, :is_personal, :boolean,  default: false
    add_column :channels, :parent_id, :integer, default: false
    User.all.each do |user|
      personal_channel = Channel.create(name: 'Personal', user_id: user.id, is_personal: true, is_public: false)
      Channel.create(name: 'Market Analyses', is_personal: true, parent_id: personal_channel.id, user_id: user.id, is_public: false)
      Channel.create(name: 'Segmented Market', is_personal: true, parent_id: personal_channel.id, user_id: user.id, is_public: false)
    end
  end
end
