class Response < ActiveRecord::Base
  attr_accessible :organization_id, :organization_id, :question_id, :requirement_id
  belongs_to :organization
  belongs_to :question
  belongs_to :requirement
  belongs_to :user_requirement
  belongs_to :user_question


end
