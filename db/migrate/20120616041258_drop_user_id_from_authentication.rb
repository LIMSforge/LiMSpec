class DropUserIdFromAuthentication < ActiveRecord::Migration
  def up
    remove_column :authentications, :user_id
  end

  def down
  end
end
