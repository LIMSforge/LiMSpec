class Crop < ActiveRecord::Migration
  def up
    drop_table :industries_requirements
  end

  def down
  end
end
