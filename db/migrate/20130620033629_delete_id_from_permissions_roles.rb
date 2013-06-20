class DeleteIdFromPermissionsRoles < ActiveRecord::Migration
  def up
    remove_index :permissions_roles, [:permission_id, :role_id]
    remove_column :permissions_roles, :id
    add_index :permissions_roles, [:permission_id, :role_id], :unique => true
  end

  def down
    add_column :permissions_roles, :id, :primary_key
  end
end
