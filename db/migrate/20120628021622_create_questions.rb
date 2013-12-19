class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :qTitle
      t.text :qText
      t.string :status

      t.timestamps
    end
  end
end
