require 'test_helper'

class AuthenticationsControllerTest < ActionController::TestCase


  setup do
    login_admin
    request.env["omniauth.auth"]= OmniAuth.config.mock_auth[:linkedin]

    @authentication = create(:authentication, provider:'linkedin', user_id: @user.id)

    @request.session[:last_seen] = Time.now
  end

  test "should get index" do

    get :index
    assert_response :success
    assert_not_nil assigns(:authentications)

  end


  test "should destroy authentication" do


    assert_difference('Authentication.count', -1) do
      delete :destroy, id: @authentication
    end

    assert_redirected_to '/sessions/new'
  end

end
