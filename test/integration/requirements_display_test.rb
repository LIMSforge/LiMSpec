require 'integration_test_helper'

class RequirementsDisplayTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "Requirement will indicate whether it is in user collection or not" do
    authenticate_admin_user
    create(:requirement)
    visit requirements_path
    page.must_have_css('#requirement_ids_')

    check('requirement_ids[]')
    click_on 'Select for Personal Collection'
    refute page.has_css?('#requirement_ids_')

  end

end
