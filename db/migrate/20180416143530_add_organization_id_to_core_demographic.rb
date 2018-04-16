class AddOrganizationIdToCoreDemographic < ActiveRecord::Migration[5.0]
  def change
    add_column :core_demographics, :organization_id, :integer
  end
end
