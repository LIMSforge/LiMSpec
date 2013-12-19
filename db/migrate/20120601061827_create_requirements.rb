class CreateRequirements < ActiveRecord::Migration
  def change
    create_table :requirements do |t|
      t.string :reqTitle
      t.text :reqText

      t.timestamps
    end
  end
end
