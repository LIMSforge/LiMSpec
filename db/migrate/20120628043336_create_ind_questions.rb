class CreateIndQuestions < ActiveRecord::Migration
  def change
    create_table :ind_questions do |t|
      t.integer :industry_id
      t.integer :question_id

      t.timestamps
    end
  end
end
