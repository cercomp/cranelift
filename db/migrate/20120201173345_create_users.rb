class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string      :login
      t.string      :password_hash
      t.string      :password_salt
      t.boolean     :admin,         :default => false
      t.references  :role
      t.boolean     :ip_block,      :default => true
      t.datetime    :last_action
      t.string      :name
      t.string      :email
      t.boolean     :active,        :default => false
      t.string      :login_type

      t.timestamps
    end
  end
end
