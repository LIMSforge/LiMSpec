require 'test_helper'

class IndustriesControllerTest < ActionController::TestCase


  setup do
    login_admin
    @request.session[:last_seen] = Time.now
  end

  test "should get index" do
    5.times do
      create(:industry)
    end
    get :index
    assert_response :success
    assert_not_nil assigns(:industries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  #test "should create industry" do
   # assert_difference('Industry.count') do
    #  post :create, industry: { indName: 'Test Industry' }
   # end

   # assert_redirected_to industry_path(assigns(:industry))
  #end

  test "should show industry" do
    @industry = create(:industry)
    get :show, id: @industry
    assert_response :success
  end

  test "should get edit" do
    @industry = create(:industry)
    get :edit, id: @industry
    assert_response :success
  end

  test "should update industry" do
    @industry = create(:industry)
    put :update, id: @industry, industry: { indName: @industry.indName }
    assert_redirected_to industry_path(assigns(:industry))
  end

  test "should destroy industry" do
    @industry = create(:industry)
    assert_difference('Industry.count', -1) do
      delete :destroy, id: @industry
    end

    assert_redirected_to industries_path
  end
end
