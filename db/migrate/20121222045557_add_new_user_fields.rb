class AddNewUserFields < ActiveRecord::Migration
  def up
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :company, :string
    add_column :users, :workPhone, :string
  end

  def down
    remove_column :users, :firstname
    remove_column :users, :lastname
    remove_column :users, :company
    remove_column :users, :workPhone
  end
end
