require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  setup do
    login_admin
    @project = FactoryGirl.create(:project)
  end

  test "should get index" do
    login_admin
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get new" do
    login_admin
    get :new
    assert_response :success
  end

  test "should create project" do
    login_admin
    assert_difference('Project.count') do
      post :create, project: { projectName: @project.projectName }
    end

    assert_redirected_to project_path(assigns(:project))
  end


  test "should get edit" do
    login_admin
    get :edit, id: @project
    assert_response :success
  end

  test "should update project" do
    login_admin
    put :update, id: @project, project: { projectName: @project.projectName }
    assert_redirected_to project_path(assigns(:project))
  end

  test "should destroy project" do
    login_admin
    assert_difference('Project.count', -1) do
      delete :destroy, id: @project
    end

    assert_redirected_to projects_path
  end

  test "should only show projects for the logged in user" do
     login_admin
     3.times do
       @project = FactoryGirl.create(:project)
       @project.project_user.user_id = @user.id
       @project.project_user.save!
     end
     3.times do
       FactoryGirl.create(:project)
     end
     get :index
     @projects = assigns(:projects)
     assert_equal(3, @projects.count)
  end
end
