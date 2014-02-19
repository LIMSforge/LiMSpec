require 'test_helper'

class ResponsesControllerTest < ActionController::TestCase
  setup do
    login_admin
  end

  test "should get index" do
    3.times do
      create(:response)
    end
    get :index
    assert_response :success
    assert_not_nil assigns(:responses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create response" do
    @myresponse = create(:response)
    assert_difference('Response.count') do
      post :create, response: { organization_id: @myresponse.organization_id, organization_id: @myresponse.organization_id, question_id: @myresponse.question_id, requirement_id: @myresponse.requirement_id }
    end

    assert_redirected_to response_path(assigns(:response))
  end

  test "should show response" do
    @myresponse = create(:response)
    get :show, id: @myresponse
    assert_response :success
  end

  test "should get edit" do
    @myresponse = create(:response)
    get :edit, id: @myresponse
    assert_response :success
  end

  test "should update response" do
    @myresponse = create(:response)
    put :update, id: @myresponse, response: { organization_id: @myresponse.organization_id, organization_id: @myresponse.organization_id, question_id: @myresponse.question_id, requirement_id: @myresponse.requirement_id }
    assert_redirected_to response_path(assigns(:response))
  end

  test "should destroy response" do
    @myresponse = create(:response)
    assert_difference('Response.count', -1) do
      delete :destroy, id: @myresponse
    end

    assert_redirected_to responses_path
  end
end
