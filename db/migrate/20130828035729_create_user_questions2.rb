class CreateUserQuestions2 < ActiveRecord::Migration
  def change
    create_table :user_questions do |t|
      t.integer :user_id
      t.string :qTitle
      t.text :qText
      t.boolean :userModified
      t.integer :position

      t.timestamps
    end
  end
end
