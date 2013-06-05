class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description

      t.timestamps
    end

    create_table :projects_users, :id => false do |t|
      t.references :project, :user
    end

    add_index :projects_users, [:project_id, :user_id], :unique => true
  end
end

