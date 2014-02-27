class UpdateVersionAndActiveForQuestionsAndUserRequirementsAndUserQuestions < ActiveRecord::Migration
  def change

    Question.unscoped.update_all("active = true, version = 1")
    UserQuestion.unscoped.update_all("version = 1")
    UserRequirement.unscoped.update_all("version = 1")

  end
end
