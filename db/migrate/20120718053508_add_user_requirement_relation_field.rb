class AddUserRequirementRelationField < ActiveRecord::Migration
  def up
    add_column :user_requirements, :relationship, :string

  end

  def down
  end
end
