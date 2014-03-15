require 'test_helper'

class UserQuestionsControllerTest < ActionController::TestCase
  setup do
    login_reader
    @user_question = create(:user_question, user: @user)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_questions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "new user question is associated with the current user" do
    login_reader
    5.times do
      post :create, user_question: {  }
    end
    get :index
    @userQuestions = assigns(:user_questions)
    assert_equal(@userQuestions.count, 5)
  end

  test "should create user_question" do
    assert_difference('UserQuestion.count') do
      post :create, user_question: {  }
    end

    assert_redirected_to user_question_path(assigns(:user_question))
  end

  test "should show user_question" do
    get :show, id: @user_question
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_question
    assert_response :success
  end

  test "should update user_question" do
    put :update, id: @user_question, user_question: {  }
    assert_redirected_to user_question_path(assigns(:user_question))
  end

  test "should destroy user_question" do
    assert_difference('UserQuestion.count', -1) do
      delete :destroy, id: @user_question
    end

    assert_redirected_to user_questions_path
  end

  test "Reverting a user question changes the text back to the source question" do
     login_reader
     @srcQuestion = create(:question)
     @userQuestion = create(:user_question, user: @user)
     @userQuestion.question_id = @srcQuestion.id
     @userQuestion.version = @srcQuestion.version
     @userQuestion.userModified = true
     @userQuestion.save!
     get :revert, id: @userQuestion
     @userQuestion = UserQuestion.find(@userQuestion.id)
     assert_equal(@userQuestion.qTitle, @srcQuestion.qTitle)
     assert_equal(@userQuestion.qText, @srcQuestion.qText)
  end

  test "Reverting a user question changes the text back to the correct version of the source question" do
    login_admin
    @question = create(:question, qTitle: 'First Version')
    3.times do
      @industry = create(:industry)
      @indQuest = create(:ind_question, industry: @industry)
      @indQuest.question_id = @question.id
      @indQuest.save!
    end

    @user_question = create(:user_question, user: @user)
    @user_question.userModified = true
    @user_question.question_id = @question.id
    @user_question.version = @question.version
    @user_question.save!
    @industry = create(:industry)
    @indUQ = create(:ind_user_question, user_question: @user_question, industry: @industry)

    #update the question here, then do the reversion.
    @question.qTitle = 'Second Version'
    @question.save!
    get :revert, id: @user_question
    @user_question = UserQuestion.find(@user_question.id)

    assert_equal(@user_question.qTitle, 'First Version')
  end

  #TODO Should we include a question as to whether to revert to current version instead of old version?

  test "When a user question sort order value is modified, the user modified flag is not altered" do
    login_reader
    @userQuestion = create(:user_question, user: @user, position: 5)
    put :update, id: @userQuestion, user_question: {position: 1}
    @userQuestion = UserQuestion.find(@userQuestion.id)
    assert(!@userQuestion.userModified)
  end

  test "When a user question is edited, the user modified flag is set" do
    login_reader
     @userQuestion = create(:user_question, user: @user, userModified: false, question_id: 1)

     put :update, id: @userQuestion, user_question: {qTitle: "Title to test changes"}
     @userQuestion = UserQuestion.find(@userQuestion.id)
     assert(@userQuestion.userModified)


  end

  test "User created user question does not have user modified flag set when edited" do
     login_reader
          @userQuestion = create(:user_question, user: @user, userModified: false)
          put :update, id: @userQuestion, user_question: {qTitle: "Title to test changes"}
          @userQuestion = UserQuestion.find(@userQuestion.id)
          assert(!@userQuestion.userModified)
  end

  test "Should only display user questions belonging to currently logged on user" do
    login_editor
          5.times do
            create(:user_question, user: @user)
          end
          login_reader
          5.times do
            create(:user_question, user: @user)
          end
          get :index
          @user_questions = assigns(:user_questions)
          assert_equal(@user_questions.count, 5)
  end

  test "Sort order updates" do
    login_reader
        user_question = Array.new
        5.times do
          @UQuest = FactoryGirl.create(:user_question, user: @user)
          user_question << @UQuest.id
        end
        tmpID = user_question[4]
        user_question[4] = user_question[0]
        user_question[0] = tmpID

        post(:updateSort, user_question: user_question)
        get :index
        @UQuests = assigns(:user_questions)
        assert_equal(@UQuests.first.id, tmpID)
  end


end
