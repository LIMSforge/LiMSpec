class CopyRequirementsDataToUserRequirements < ActiveRecord::Migration
  def up
    UserRequirement.connection.execute('update user_requirements
    set req_title = (select reqTitle from requirements where requirements.id = requirement_id)')

    UserRequirement.connection.execute('update user_requirements
    set req_text = (select reqText from requirements where requirements.id = requirement_id)')
  end

end
