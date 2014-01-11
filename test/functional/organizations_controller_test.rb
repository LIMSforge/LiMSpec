require 'test_helper'

class OrganizationsControllerTest < ActionController::TestCase


  setup do
    login_admin
    @request.session[:last_seen] = Time.now
  end

  test "should get index" do
    5.times do
      create(:organization)
    end
    get :index
    assert_response :success
    assert_not_nil assigns(:organizations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show organization" do
    @organization = create(:organization)
    get :show, id: @organization
    assert_response :success
  end

  test "should get edit" do
    @organization = create(:organization)
    get :edit, id: @organization
    assert_response :success
  end

  test "should update organization" do
    @organization = create(:organization)
    put :update, id: @organization, organization: { orgName: @organization.orgName }
    assert_redirected_to organization_path(assigns(:organization))
  end

  test "should destroy organization" do
    @organization = create(:organization)
    assert_difference('Organization.count', -1) do
      delete :destroy, id: @organization
    end

    assert_redirected_to organizations_path
  end
end
