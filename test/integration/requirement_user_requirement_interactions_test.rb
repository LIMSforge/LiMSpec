require 'integration_test_helper'

describe "Requirement and user requirement integration" do


  it "Should create a matching user requirement when the add to personal collection button is clicked." do
         authenticate_basic_user
         requirement = create(:requirement, reqTitle: 'Integration Test Requirement')
         visit requirements_path
         check('requirement_ids[]')
         click_on 'Select for Personal Collection'
         visit user_requirements_path
         assert(page.has_content?('Integration Test Requirement'))
  end



end
