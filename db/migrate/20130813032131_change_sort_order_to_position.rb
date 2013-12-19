class ChangeSortOrderToPosition < ActiveRecord::Migration
  def up
    rename_column :user_requirements, :sortOrder, :position
  end

  def down
  end
end
