class QuestionVersion < ActiveRecord::Base
  attr_accessible :qText, :qTitle, :quest_id, :status, :version
end
