class IndRequirement < ActiveRecord::Base
  attr_accessible :industry_id, :requirement_id
  belongs_to :industry
  belongs_to :requirement
end
