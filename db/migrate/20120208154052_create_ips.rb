class CreateIps < ActiveRecord::Migration
  def change
    create_table :ips do |t|
      t.string :ip
      t.string :cidr
      t.text :description

      t.timestamps
    end
  end
end
