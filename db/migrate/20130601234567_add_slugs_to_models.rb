class AddSlugsToModels < ActiveRecord::Migration
  def change
    add_column :projects, :slug, :string
    add_column :repositories, :slug, :string

    add_index :projects, :slug, :unique => true
    add_index :repositories, :slug, :unique => true
  end
end
