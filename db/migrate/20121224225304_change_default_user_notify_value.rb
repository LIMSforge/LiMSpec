class ChangeDefaultUserNotifyValue < ActiveRecord::Migration
  def up
    change_column_default(:users, :emailSystemNotify, true)
  end

  def down
    change_column_default(:users, :emailSystemNotify, nil)
  end
end
