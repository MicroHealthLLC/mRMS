class AddEditDataSetToPermission < ActiveRecord::Migration[5.2]
  def change
    add_column :channel_permissions, :can_add_edit_data_set, :boolean, default: false
  end
end
