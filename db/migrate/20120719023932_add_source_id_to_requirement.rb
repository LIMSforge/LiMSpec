class AddSourceIdToRequirement < ActiveRecord::Migration
  def change
    add_column :requirements, :source_id, :integer
  end
end
