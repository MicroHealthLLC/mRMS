class UpdateUserStateInUsers < ActiveRecord::Migration[5.2]
  def change
    User.find_each do |u|
      u.state = :active
      u.save
    end
  end
end
