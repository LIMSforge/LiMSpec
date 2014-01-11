require 'test_helper'

class AppSettingsControllerTest < ActionController::TestCase
  setup do
    login_admin
    @request.session[:last_seen] = Time.now
  end

  test "should show app_setting for current user" do

    get :show
    assert_response :success
    assigns(:app_setting)
  end

  test "should get edit for current user" do

    get :edit
    assert_response :success
  end

  test "should update app_setting" do

    @app_setting = AppSetting.find_by_user_id(@user.id)

    put :update, id: @app_setting, app_setting: { showIndustry: @app_setting.showIndustry, user_id: @app_setting.user_id }
    assert_redirected_to edit_user_path(@user)
  end

  test "updated app settings should be reflected in the appropriate session variables" do
    @app_setting = AppSetting.find_by_user_id(@user.id)
    put :update, id: @app_setting, app_setting: { showIndustry: @app_setting.showIndustry, user_id: @app_setting.user_id }
    assert_not_nil(session['showIndustry'])
  end


end
