require  'integration_test_helper'

class RequirementUserRequirementInteractions < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  before do
      original_session = Sunspot.session
      Sunspot.session = Sunspot::Rails::StubSessionProxy.new(original_session)
    end
    after do
      Sunspot.session = original_session
    end
  test "When the add to personal collection button is clicked, a matching user requirement record is created" do
         authenticate_basic_user
         requirement = create(:requirement, reqTitle: 'Integration Test Requirement')
         visit requirements_path
         check('requirement_ids[]')
         click_on 'Select for Personal Collection'
         visit user_requirements_path
         assert(page.has_content?('Integration Test Requirement'))
  end



end
