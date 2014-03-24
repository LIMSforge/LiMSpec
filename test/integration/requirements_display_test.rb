require 'integration_test_helper'

describe 'requirements display integration' do
  # test "the truth" do
  #   assert true
  # end
  it "will indicate whether a requirement is in user collection or not" do
    authenticate_admin_user
    create(:requirement)
    visit requirements_path
    page.must_have_css('#requirement_ids_')

    check('requirement_ids[]')
    click_on 'Select for Personal Collection'
    refute page.has_css?('#requirement_ids_')

  end

end
