class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.references  :project
      t.string      :name
      t.string      :url
      t.string      :login
      t.string      :password
      t.boolean     :enable_autoupdate, :default => false

      t.timestamps
    end
  end
end
