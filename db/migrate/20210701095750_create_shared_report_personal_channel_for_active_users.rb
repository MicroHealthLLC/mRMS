class CreateSharedReportPersonalChannelForActiveUsers < ActiveRecord::Migration[5.2]
  def change
    User.where(state: 'active').each do |u|
      Channel.personal.where(user_id: u.id, name: 'Shared Report', option: 3, description: 'Display shared reports').first_or_create
    end
  end
end
