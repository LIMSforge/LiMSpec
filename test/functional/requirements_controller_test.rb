require 'test_helper'
include FactoryGirl::Syntax::Methods

class RequirementsControllerTest < ActionController::TestCase

  setup do



  end

  test "should get index" do

    login_admin

    10.times do
              FactoryGirl.create(:requirement)

    end

    get :index
    @requirements = assigns(:requirements)
    assert_response :success
    assert_equal(@requirements.length, 10)
  end

  test "administrators can create new requirements" do
    login_admin
    @requirement = create(:requirement)
    assert_difference('Requirement.count') do
      post :create, requirement: { reqText: @requirement.reqText, reqTitle: @requirement.reqTitle, status: @requirement.status }
    end

  end
  test "editors can create new requirements" do

    login_editor
    @requirement = create(:requirement)
    assert_difference('Requirement.count') do
        post :create, requirement: { reqText: @requirement.reqText, reqTitle: @requirement.reqTitle, status: @requirement.status }
    end

  end

  test "new requiremetns created by editors should get submitted status" do

    login_editor
    post :create, requirement: {reqText: 'Test new requirement', reqTitle: 'New Submitted Req'}
    @requirement = Requirement.first

    assert_equal(@requirement.status, 'Submitted')


  end
  test "readers cannot create new requirements" do

    login_reader
    @requirement = create(:requirement)
    post :create, requirement: { reqText: @requirement.reqText, reqTitle: @requirement.reqTitle, status: @requirement.status }
    assert_response :redirect

  end
  test "should get new" do
    login_admin
    get :new
    assert_response :success
  end

  test "should create requirement" do
    login_admin
    @requirement = create(:requirement)
    assert_difference('Requirement.count') do
      post :create, requirement: { reqText: @requirement.reqText, reqTitle: @requirement.reqTitle, status: @requirement.status }
    end

    assert_redirected_to requirement_path(assigns(:requirement))
  end

  test "should show requirement" do
    login_reader
    @requirement = create(:requirement)
    get :show, id: @requirement
    assert_response :success
  end

  test "should show requirement without category" do
    login_reader
    @requirement = create(:requirement)
    get :show, id: @requirement
    assert_response :success
  end

  test "should get edit" do
    login_admin
    @requirement = create(:requirement)
    get :edit, id: @requirement
    assert_response :success
  end

  test "should update requirement" do
    login_admin
    @requirement = create(:requirement)
    put :update, id: @requirement, requirement: { reqText: @requirement.reqText, reqTitle: "Updated requirement", status: @requirement.status }
    assert_redirected_to requirement_path(assigns(:requirement))
    assert(flash[:notice].include?("successfully updated"))
  end


  test "should destroy requirement" do
    login_admin
    @requirement = create(:requirement)
    assert_difference('Requirement.count', -1) do
      delete :destroy, id: @requirement
    end

    assert_redirected_to requirements_path
  end

  test "Requirements created via submission from a user requirement show a status of submitted" do

    #TODO move creation from user requirement test to an integration test prior to implementation
  end

  test "A submitted requirement which is not approved for public usage is deleted" do
    login_admin
    req = create(:requirement, status: "Submitted")
    @reqs = Requirement.where(id: req.id)
    assert_equal(@reqs.count, 1)
    put :update, id: req.id, requirement: { reqText: req.reqText, reqTitle: "About to be deleted", status: "Rejected" }

    @reqs = Requirement.where(id: req.id)
    assert_equal(@reqs.count, 0)
  end

  test "When a requirement is deleted, all user requirement references are cleared" do


    login_admin
    req = create(:requirement)
    ureq1 = create(:user_requirement, requirement_id: req.id)
    ureq2 = create(:user_requirement, requirement_id: req.id)

    delete :destroy, id: req

    @userreqs = UserRequirement.where(requirement_id: req.id)
    assert_equal(@userreqs.count, 0)

  end



  test "Should show submitted requirements to admins" do
    login_admin
    5.times do
      create(:reqWithCat, status: :Public)
      create(:reqWithCat, status: :Submitted)
    end
    get :review
    @requirements = assigns(:requirements)
    assert_equal(@requirements.length, 5)

  end


  test "Only requirements associated with a user's industries are returned when that application setting is selected" do
    login_reader
    session[:showIndustry] = true
    create(:requirement)
    req = create(:reqWithIndustry)
    get :index
    @requirements = assigns(:requirements)
    assert_equal(@requirements.length, 1)

  end


end



