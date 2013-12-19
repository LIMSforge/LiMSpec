class AddCategoryIdToUserRequirement < ActiveRecord::Migration
  def change
    add_column :user_requirements, :category_id, :integer
  end
end
