class CreateProductClasses < ActiveRecord::Migration
  def change
    create_table :product_classes do |t|
      t.string :className

      t.timestamps
    end
  end
end
