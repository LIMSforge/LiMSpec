class IndUserRequirement < ActiveRecord::Base
  attr_accessible :industry_id, :user_requirement_id
  belongs_to :industry
  belongs_to :user_requirement

  before_save do
    if (!self.user_requirement.new_record?) && (!self.user_requirement.requirement_id.nil?)
      self.user_requirement.userModified = true
      self.user_requirement.save!
    end

  end

  before_destroy do
    if (!self.user_requirement.new_record?) && (!self.user_requirement.requirement_id.nil?)
          self.user_requirement.userModified = true
          self.user_requirement.save!
    end
  end
end
