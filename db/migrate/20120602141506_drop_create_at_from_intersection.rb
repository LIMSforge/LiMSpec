class DropCreateAtFromIntersection < ActiveRecord::Migration
  def up
    remove_column :industries_requirements, :created_at
  end

  def down
  end
end
