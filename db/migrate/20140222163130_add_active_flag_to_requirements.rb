class AddActiveFlagToRequirements < ActiveRecord::Migration
  def change
    add_column :requirements, :active, :boolean
  end
end
