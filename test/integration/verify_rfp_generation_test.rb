require 'integration_test_helper'

class VerifyRfpGenerationTest < ActionDispatch::IntegrationTest

  test "Clicking the Generate LiMSpec Public Items link should produce RFP Document" do
    authenticate_admin_user
    click_link('Public Items')
    assert page.response_headers['Content-Disposition'].include?("filename=\"LiMSpec_RFP.odt\"")
  end

  test "Clicking the Generate LiMSpec My Items link should produce RFP Document" do
    authenticate_admin_user
    click_link('My Items')
    assert page.response_headers['Content-Disposition'].include?("filename=\"LiMSpec_RFP.odt\"")
  end

end
