class CreateIndUserQuestions < ActiveRecord::Migration
  def change
    create_table :ind_user_questions do |t|
      t.integer :industry_id
      t.integer :user_question_id
      t.timestamps
    end
  end
end
