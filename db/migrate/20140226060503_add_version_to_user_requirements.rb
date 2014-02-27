class AddVersionToUserRequirements < ActiveRecord::Migration
  def change
    add_column :user_requirements, :version, :integer
  end
end
