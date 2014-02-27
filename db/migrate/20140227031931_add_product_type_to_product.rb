class AddProductTypeToProduct < ActiveRecord::Migration
  def change
    add_column :products, :productClass, :string
  end
end
