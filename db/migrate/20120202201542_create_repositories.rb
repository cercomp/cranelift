class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.references  :project
      t.string      :name
      t.string      :url
      t.boolean     :enable_autoupdate, :default => false
      t.string      :autoupdate_login
      t.string      :autoupdate_password

      t.timestamps
    end
  end
end
