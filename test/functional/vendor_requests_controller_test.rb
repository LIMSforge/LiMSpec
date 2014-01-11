require 'test_helper'


class VendorRequestsControllerTest < ActionController::TestCase

  test "should create open document formatted document when requested" do
    get :produceRFP
    assert_response :redirect
  end
end
