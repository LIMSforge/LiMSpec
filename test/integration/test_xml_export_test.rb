require 'integration_test_helper'

describe "XML export integration" do

  it "Should create an xml export file when clicking on the export XML from the requirements page" do
    authenticate_admin_user
    5.times do
      create(:reqWithCat)
    end
    click_link('Export XML')
    assert page.response_headers['Content-Disposition'].include?("filename=\"Requirements.xml\"")
  end

  it "Should create an xml export file when clicking on the export XML link on the questions page" do
      authenticate_admin_user
      5.times do
        create(:question)
      end
      visit questions_path
      click_link('Export XML')
      assert page.response_headers['Content-Disposition'].include?("filename=\"Questions.xml\"")
    end

end
