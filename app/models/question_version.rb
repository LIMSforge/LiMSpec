class QuestionVersion < ActiveRecord::Base
  attr_accessible :qText, :qTitle, :quest_id, :status, :version

  has_and_belongs_to_many :products
  belongs_to :question, foreign_key: "quest_id"

end
