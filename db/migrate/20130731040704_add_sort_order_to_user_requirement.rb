class AddSortOrderToUserRequirement < ActiveRecord::Migration
  def change
    add_column :user_requirements, :sortOrder, :integer
  end
end
