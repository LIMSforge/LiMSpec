class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :orgName
      t.string :orgType

      t.timestamps
    end
  end
end
