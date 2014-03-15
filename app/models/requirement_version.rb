class RequirementVersion < ActiveRecord::Base
  attr_accessible :category_id, :reqText, :reqTitle, :req_id, :status, :version
  belongs_to :requirement
end
