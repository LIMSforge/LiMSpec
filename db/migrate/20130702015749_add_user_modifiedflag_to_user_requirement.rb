class AddUserModifiedflagToUserRequirement < ActiveRecord::Migration
  def change
    add_column :user_requirements, :userModified, :boolean

  end
end
