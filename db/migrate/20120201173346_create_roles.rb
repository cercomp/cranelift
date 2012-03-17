class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string  :name
      t.text    :description

      t.timestamps
    end
    
    create_table :project_users do |t|
      t.references :user
      t.references :role
      t.references :project

      t.timestamps
    end
  end
end

