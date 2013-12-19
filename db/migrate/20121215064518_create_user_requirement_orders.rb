class CreateUserRequirementOrders < ActiveRecord::Migration
  def change
    create_table :user_requirement_orders do |t|
      t.integer :user_id
      t.integer :requirement_id
      t.integer :requirementOrder

      t.timestamps
    end
  end
end
