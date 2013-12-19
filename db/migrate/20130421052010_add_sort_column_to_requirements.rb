class AddSortColumnToRequirements < ActiveRecord::Migration
  def change

    add_column :requirements, :sortOrder, :integer

  end
end
