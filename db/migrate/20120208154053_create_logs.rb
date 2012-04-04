class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.references  :user
      t.string      :message

      t.timestamps
    end
  end
end
