class CreateOrganizationClientTable < ActiveRecord::Migration
  def up
    create_table :vendor_clients do |t|
      t.integer :vendor_id
      t.integer :client_id
    end
  end

  def down
    drop_table :vendor_clients
  end
end
