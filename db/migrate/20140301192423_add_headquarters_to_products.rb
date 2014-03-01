class AddHeadquartersToProducts < ActiveRecord::Migration
  def change
    add_column :products, :headquarterLocation, :string
  end
end
