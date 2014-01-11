class CreateProjectOrganizationTable < ActiveRecord::Migration
  def up
    create_table :project_organizations do |t|
      t.integer :project_id
      t.integer :organization_id
      t.string :relationship
    end
  end

  def down
    drop_table :project_organizations
  end
end
