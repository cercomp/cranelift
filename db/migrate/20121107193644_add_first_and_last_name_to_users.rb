class AddFirstAndLastNameToUsers < ActiveRecord::Migration
  def up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string

    User.all.each do |user|
      names = user.name.split
      user.first_name = names.shift
      user.last_name = names.join(' ')
      user.save
    end

    remove_column :users, :name
  end

  def down
    add_column :users, :name, :string

    User.all.each do |user|
      user.name = [user.first_name, user.last_name].join(' ')
    end

    remove_column :users, :first_name
    remove_column :users, :last_name
  end
end
