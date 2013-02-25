class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.references  :project
      t.string      :name
      t.string      :slug
      t.string      :url
      t.string      :login
      t.string      :password
      t.boolean     :enable_autoupdate, :default => false

      t.timestamps
    end

    add_index :repositories, :slug, unique: true
  end
end
