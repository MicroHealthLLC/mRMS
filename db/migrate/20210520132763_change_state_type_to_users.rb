class ChangeStateTypeToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users , :state , :integer

    User.find_each do |u|
      u.state = :active
      u.save
    end
  end
end


