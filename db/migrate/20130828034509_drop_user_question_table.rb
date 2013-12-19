class DropUserQuestionTable < ActiveRecord::Migration
  def up
    drop_table :user_questions
  end

  def down
  end
end
