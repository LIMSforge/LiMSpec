class CopyQuestionDataToUserQuestions < ActiveRecord::Migration
  def up
    UserQuestion.connection.execute('update user_questions
        set qTitle = (select qTitle from questions where questions.id = question_id)')

    UserQuestion.connection.execute('update user_questions
            set qText = (select qText from questions where questions.id = question_id)')
  end


end
