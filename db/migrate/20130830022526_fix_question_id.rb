class FixQuestionId < ActiveRecord::Migration
  def up
    add_column :user_questions, :question_id, :integer
  end

  def down
  end
end
