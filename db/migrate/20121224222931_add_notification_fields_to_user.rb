class AddNotificationFieldsToUser < ActiveRecord::Migration
  def up
      add_column :users, :emailSystemNotify, :boolean
      add_column :users, :emailGeneral, :boolean

    end

    def down
      remove_column :users, :emailSystemNotify
      remove_column :users, :emailGeneral
    end
end
