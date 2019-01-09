class ChangeLdapAuthColumn < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :ldap_authenticatable, :string, :default => ''
  end
end
