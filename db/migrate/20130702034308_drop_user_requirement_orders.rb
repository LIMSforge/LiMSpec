class DropUserRequirementOrders < ActiveRecord::Migration
  def up
    drop_table :user_requirement_orders

  end


end
