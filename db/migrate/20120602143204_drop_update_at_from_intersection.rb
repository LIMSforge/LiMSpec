class DropUpdateAtFromIntersection < ActiveRecord::Migration
  def up
    remove_column :industries_requirements, :updated_at
  end

  def down
  end
end
