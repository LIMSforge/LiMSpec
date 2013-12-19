class IndUserQuestion < ActiveRecord::Base
      attr_accessible :industry_id, :user_question_id
      belongs_to :user_question
      belongs_to :industry
  before_save do
    if (!self.user_question.new_record?) && (!self.user_question.question_id.nil?)
      self.user_question.userModified = true
      self.user_question.save!
    end
  end
  before_destroy do
    if (!self.user_question.new_record?) && (!self.user_question.question_id.nil?)
        self.user_question.userModified = true
        self.user_question.save!
    end
  end
end
