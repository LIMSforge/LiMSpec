require 'integration_test_helper'

describe "Requirement editing integration" do
  # test "the truth" do
  #   assert true
  # end

  it "should have enabled button to revert to source requirement when has been modified" do

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

  it "should not have button to revert to source requirement when not modified" do

    authenticate_basic_user
    requirement = create(:requirement)
    visit requirements_path
    check('requirement_ids[]')
    click_on 'Select for Personal Collection'
    visit user_requirements_path
    assert(page.has_no_content?('Revert'))

  end
end
