class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :password_hash
      t.string :password_salt
      t.boolean :admin
      t.boolean :ip_block
      t.datetime :last_action
      t.string :name
      t.string :email
      t.boolean :active
      t.string :login_type

      t.timestamps
    end
  end
end
