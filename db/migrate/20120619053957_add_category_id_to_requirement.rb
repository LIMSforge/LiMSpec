class AddCategoryIdToRequirement < ActiveRecord::Migration
  def change
    add_column :requirements, :category_id, :integer
  end
end
