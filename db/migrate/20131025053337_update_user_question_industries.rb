class UpdateUserQuestionIndustries < ActiveRecord::Migration
  def up
    @user_questions = UserQuestion.all
          @user_questions.each do |uquest|
          if !uquest.question_id.nil?


          @targetQuestion = Question.find(uquest.question_id)
          @targetQuestion.industries.each do |ind|
                    indQ = IndUserQuestion.new
                    indQ.industry_id = ind.id
                    indQ.user_question_id = uquest.id
                    indQ.save
                end
        end
      end
  end


end
