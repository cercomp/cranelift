class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :url
      t.boolean :enable_autoupdate
      t.string :autoupdate_login
      t.string :autoupdate_password

      t.timestamps
    end
  end
end
