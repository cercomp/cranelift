class ChangeAutoUpdateDefaultValue < ActiveRecord::Migration
  def up
    change_column_default :repositories, :enable_autoupdate, true
  end

  def down
    change_column_default :repositories, :enable_autoupdate, false
  end
end
