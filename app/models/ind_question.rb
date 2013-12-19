class IndQuestion < ActiveRecord::Base
  belongs_to :industry
  belongs_to :question
  attr_accessible :industry_id, :question_id
end
