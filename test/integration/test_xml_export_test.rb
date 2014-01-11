require 'integration_test_helper'

class TestXmlExportTest < ActionDispatch::IntegrationTest

  test "Clicking on export xml on requirements page creates an xml export file" do
    authenticate_admin_user
    5.times do
      create(:reqWithCat)
    end
    click_link('Export XML')
    assert page.response_headers['Content-Disposition'].include?("filename=\"Requirements.xml\"")
  end

  test "Clicking on export xml on questions page creates an xml export file" do
      authenticate_admin_user
      5.times do
        create(:question)
      end
      visit questions_path
      click_link('Export XML')
      assert page.response_headers['Content-Disposition'].include?("filename=\"Questions.xml\"")
    end

end
