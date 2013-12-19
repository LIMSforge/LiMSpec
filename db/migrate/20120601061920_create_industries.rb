class CreateIndustries < ActiveRecord::Migration
  def change
    create_table :industries do |t|
      t.string :indName

      t.timestamps
    end
  end
end
