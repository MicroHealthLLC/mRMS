class AddNewsToEnabledModule < ActiveRecord::Migration[5.0]
  def change
    EnabledModule.create(name: 'news')
  end
end
