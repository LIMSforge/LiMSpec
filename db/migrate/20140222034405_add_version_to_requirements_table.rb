class AddVersionToRequirementsTable < ActiveRecord::Migration
  def change
    add_column :requirements, :version, :integer
  end
end
