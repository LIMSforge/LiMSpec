class SetUserItemSortOrder < ActiveRecord::Migration
  def up
    @user_requirements = UserRequirement.all
    @user_requirements.each do |ureq|
      ureq.position = ureq.id
      ureq.save
    end

    @user_questions = UserQuestion.all
    @user_questions.each do |uquest|
       uquest.position = uquest.id
       uquest.save
    end
  end

end
