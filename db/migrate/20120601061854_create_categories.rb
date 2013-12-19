class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :catName

      t.timestamps
    end
  end
end
