class UpdateUserRequirementsIndustries < ActiveRecord::Migration
  def up
      @user_requirements = UserRequirement.all
      @user_requirements.each do |ureq|

        if !ureq.requirement_id.nil?


      @targetRequirement = Requirement.find_by_id(ureq.requirement_id)
      if !@targetRequirement.nil?

        ureq.requirement_id = nil
        ureq.save

        @targetRequirement.industries.each do |ind|
                indUreq = IndUserRequirement.new
                indUreq.industry_id = ind.id
                indUreq.user_requirement_id = ureq.id
                indUreq.save
        end
      end
    end
  end
  end
end
