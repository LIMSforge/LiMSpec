require 'integration_test_helper'

class RequirementEditingDisplayTest < ActionDispatch::IntegrationTest
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
  test "Edited user requirements should have enabled button to revert to source requirement" do

     authenticate_basic_user
     requirement = create(:requirement)
     visit requirements_path
     check('requirement_ids[]')
     click_on 'Select for Personal Collection'
     visit user_requirements_path
     click_on 'Edit'
     fill_in 'user_requirement_req_title', with: 'Changed requirement'
     click_button 'Update User requirement'
     visit user_requirements_path
     assert(page.has_content?('Revert'))

  end

  test "Non-edited requirements should not have button to revert to source requirement" do

    authenticate_basic_user
    requirement = create(:requirement)
    visit requirements_path
    check('requirement_ids[]')
    click_on 'Select for Personal Collection'
    visit user_requirements_path
    assert(page.has_no_content?('Revert'))

  end
end
