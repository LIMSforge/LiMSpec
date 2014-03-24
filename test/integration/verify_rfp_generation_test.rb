require 'integration_test_helper'

describe "RFP generation integration" do

  it "Should produce RFP Document when you click the Generate LiMSpec Public Items link" do
    authenticate_admin_user
    click_link('Public Items')
    assert page.response_headers['Content-Disposition'].include?("filename=\"LiMSpec_RFP.odt\"")
  end

  it "Should produce RFP Document when you click the Generate LiMSpec My Items link" do
    authenticate_admin_user
    click_link('My Items')
    assert page.response_headers['Content-Disposition'].include?("filename=\"LiMSpec_RFP.odt\"")
  end

end
