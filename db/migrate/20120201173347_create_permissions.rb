class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :name
      t.string :controller
      t.string :actions

      t.timestamps
    end
    
    create_table :permissions_roles, :id => false do |t|
      t.references :permission, :role
    end
    add_index :permissions_roles, [:permission_id, :role_id], :unique => true
  end
end

