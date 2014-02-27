require 'test_helper'
include FactoryGirl::Syntax::Methods

class UserRequirementsControllerTest < ActionController::TestCase
  #TODO Make sure all page links etc. are tested in integration testing - especially the specialty links

  test "should get index" do
    login_reader
    5.times do
      userReq = create(:user_requirement, user_id: @user.id)
    end
    get :index
    assert_response :success
    assert_not_nil assigns(:user_requirements)
  end

  test "should get new" do
    login_reader
    get :new
    assert_response :success
  end

  test "new user requirement is associated with the current user" do
      login_reader
      5.times do
        post :create, user_requirement: {req_text: "Test User Requirement", req_title: "A random title" }
      end
      get :index
      @userRequirements = assigns(:user_requirements)
      assert_equal(@userRequirements.count, 5)
    end

  test "editor should create user_requirement" do
    login_editor
    assert_difference('UserRequirement.count') do
      post :create, user_requirement: {req_text: "Test User Requirement", req_title: "A random title" }
    end

    assert_redirected_to user_requirement_path(assigns(:user_requirement))
  end

  test "should show user_requirement" do
    login_reader
    @user_requirement = create(:user_requirement, user: @user)
    get :show, id: @user_requirement
    assert_response :success
  end

  test "should get edit" do
    login_reader
    @user_requirement = create(:user_requirement, user: @user)
    get :edit, id: @user_requirement
    assert_response :success
  end

  test "should update user_requirement" do
    login_reader
    @user_requirement = create(:user_requirement, user: @user)
    put :update, id: @user_requirement, user_requirement: {req_text: "Test User Requirement", req_title: "A random title"  }
    assert_redirected_to user_requirement_path(assigns(:user_requirement))
  end

  test "should destroy user_requirement" do
    login_reader
    @user_requirement = create(:user_requirement, user: @user)
    assert_difference('UserRequirement.count', -1) do
      delete :destroy, id: @user_requirement
    end

    assert_redirected_to user_requirements_path
  end

  test "should sort records based on category, then position value" do
    login_reader
    @category1 = create(:category, catName: "AlphaCategory")
    @category2 = create(:category, catName: "BetaCategory")
    x = 0
    5.times do
        sortOrd = 5-x
        @user_requirement = create(:user_requirement, user: @user, position: sortOrd)
        if sortOrd%2 == 0
          @user_requirement.category_id = @category2.id
        else
          @user_requirement.category_id = @category1.id
        end
        @user_requirement.save!
        x = x + 1
    end
    get :index
    @urequirements = assigns(:user_requirements)
    expectedSortValue = 1
    @urequirements.each do |ur|
        assert_equal(ur.position, expectedSortValue)
        expectedSortValue = expectedSortValue + 2
        if expectedSortValue > 5
          expectedSortValue = 2
        end
    end
  end

  test "Should only display requirements belonging to currently logged on user" do
      login_editor
      5.times do
        create(:user_requirement, user: @user)
      end
      login_reader
      5.times do
        create(:user_requirement, user: @user)
      end
      get :index
      @user_requirements = assigns(:user_requirements)
      assert_equal(@user_requirements.count, 5)
  end
  test "User created user requirement does not have user modified flag set when edited" do
     login_reader
     @user_requirement = create(:user_requirement, user: @user)
     put :update, id: @user_requirement, user_requirement: {req_text: "Test User Requirement", req_title: "A random title"  }
     @user_requirement = UserRequirement.find(@user_requirement.id)
     assert(!@user_requirement.userModified)
  end
  test "When a user requirement is edited, the user modified flag is set" do
    login_reader
    @user_requirement = create(:user_requirement, user: @user)
    @requirement = create(:requirement)
    @user_requirement.requirement_id = @requirement.id
    @user_requirement.save
    put :update, id: @user_requirement, user_requirement: {req_text: "Test User Requirement", req_title: "A random title"  }
    @user_requirement = UserRequirement.find(@user_requirement.id)
    assert(@user_requirement.userModified)
  end

  test "When a user requirement sort order value is modified, the user modified flag is not altered" do
    login_reader
     @user_requirement = create(:user_requirement, user: @user, position: 5)
     put :update, id: @user_requirement, user_requirement: {position: 1}
     @user_requirement = UserRequirement.find(@user_requirement.id)
     assert(!@user_requirement.userModified)
  end

  test "Reverting a user requirement changes the text back to the source requirement" do
    #TODO test entire logic tree for this controller action
    login_reader
    @requirement = create(:reqWithNamedCat, categoryName: 'Test Category', categoryAbbr: 'TC')
    3.times do
      @industry = create(:industry)
      @indReq = create(:ind_requirement, industry: @industry)
      @indReq.requirement_id = @requirement.id
      @indReq.save!
    end

    @user_requirement = create(:user_requirement, user: @user)
    @category = create(:category, catName: "Special Category")
    @user_requirement.category_id = @category.id
    @user_requirement.userModified = true
    @user_requirement.requirement_id = @requirement.id
    @user_requirement.save!
    @industry = create(:industry)
    @indUR = create(:ind_user_requirement, user_requirement: @user_requirement, industry: @industry)

    #update the requirement here, then do the reversion

    get :revert, id: @user_requirement
    @user_requirement = UserRequirement.find(@user_requirement.id)

    assert_equal(@user_requirement.industries.count, 3)
    assert_equal(@user_requirement.category.catName, 'Test Category')
    assert_equal(@user_requirement.req_text, @requirement.reqText)
    assert_equal(@user_requirement.req_title, @requirement.reqTitle)
  end

  test "Reverting a user requirement changes the text back to the correct version of the source requirement" do
    flunk("Not yet implemented")
  end



  test "New user requirements should have default sort order defined" do
     login_reader
     5.times do
       post :create, user_requirement: {req_text: "Test User Requirement", req_title: "A random title" }
     end
     @userReq = UserRequirement.last

     assert_not_nil(@userReq.position)
  end

  test "Sort Order updates" do
    login_reader
    user_requirement = Array.new
    5.times do
      @UReq = create(:user_requirement, user: @user)
      user_requirement << @UReq.id
    end
    tmpID = user_requirement[4]
    user_requirement[4] = user_requirement[0]
    user_requirement[0] = tmpID
    #params[:user_requirement] = user_requirement
    post(:updateSort, user_requirement: user_requirement)
    get :index
    @UReqs = assigns(:user_requirements)
    assert_equal(@UReqs.first.id, tmpID)
  end

end
