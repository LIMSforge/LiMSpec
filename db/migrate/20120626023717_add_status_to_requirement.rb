class AddStatusToRequirement < ActiveRecord::Migration
  def change
    add_column :requirements, :status, :string
  end
end
