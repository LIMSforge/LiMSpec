require 'test_helper'


class QuestionsControllerTest < ActionController::TestCase
  setup do
    login_admin
    @question = create(:question)
    @request.session[:last_seen] = Time.now
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:questions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create question" do
    assert_difference('Question.count') do
      post :create, question: { qText: @question.qText, qTitle: @question.qTitle, status: @question.status }
    end

    assert_redirected_to question_path(assigns(:question))
  end

  test "should show question" do
    get :show, id: @question
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @question
    assert_response :success
  end

  test "should update question" do
    put :update, id: @question, question: { qText: @question.qText, qTitle: @question.qTitle, status: @question.status }
    assert_redirected_to question_path(assigns(:question))
    assert(flash[:notice].include?("successfully updated"))
  end

  test "should destroy question" do
    assert_difference('Question.count', -1) do
      delete :destroy, id: @question
    end

    assert_redirected_to questions_path
  end

  test "Created questions should have submitted status when current user doesn't have approve ability" do

    login_editor
    post :create, question: { qText: 'Test question', qTitle: 'Test question title'}
    @question = assigns(:question)
    assert_equal(@question.status, 'Submitted')
  end

  test "New questions should have submitted status when current user does not have approve ability" do

    login_editor
    get :new
    @question = assigns(:question)
    assert_equal(@question.status, 'Submitted')
  end

  test "Created questions should have public status when current user has approve ability" do

    post :create, question: { qText: @question.qText, qTitle: @question.qTitle, status: @question.status }
    @question = assigns(:question)
    assert(@question.status, 'Public')
  end

  test "New questions should have public status when current user has approve ability" do
      login_admin
      get :new
      @question = assigns(:question)
      assert_equal(@question.status, 'Public')
  end


test "New questions should not display status dropdown for users without approve ability" do

  login_editor
  get :new
  assert_select "div#qStatusField", false

 end

  test "New questions should display status for users with approve ability" do
    login_admin
    get :new
    assert_select "div#qStatusField"
  end

  test "Should show submitted questions to admins" do
      get :review
      assert_not_nil assigns(:questions)

  end


  test "Questions submitted for addition to personal suite should have new user_question records created" do
       login_admin
       question_ids = Array.new
       questionOne = create(:question)
       questionTwo = create(:question)
       question_ids << questionOne << questionTwo
       put :change_selected_questions, {'question_ids' => question_ids, 'Select'=> 1}
       assert(questionOne.copied_by_me?(@user.id))
       assert(questionTwo.copied_by_me?(@user.id))


    end

    test "Questions submitted for addition to personal suite which already belong to the user do not get an additional user_question record" do
      login_admin
      @question = create(:question)
      @userQuestion = create(:user_question, user_id: @user.id)
      @userQuestion.question_id = @question.id
      @userQuestion.save!
      assert(@question.copied_by_me?(@user.id))
      question_ids = Array.new
      question_ids << @question.id
      put :change_selected_questions, {'question_ids' => question_ids, 'Select'=> 1}
      assert(@question.user_questions.where("user_id = ?", session[:user_id]).length==1)
    end

    test "Only questions associated with a user's industries are displayed when that application setting is selected" do
      login_admin
      industryOne = create(:industry, indName: 'industryOne')
      industryTwo = create(:industry, indName: 'industryTwo')
      3.times do
        quest = create(:question)
        indQuest = create(:ind_question)
        indQuest.question_id = quest.id
        indQuest.industry_id = industryOne.id
        indQuest.save!
      end
      3.times do
          quest = create(:question)
          indQuest = create(:ind_question)
          indQuest.question_id = quest.id
          indQuest.industry_id = industryTwo.id
          indQuest.save!
      end
      @user_industry = IndUser.new
      @user_industry.user_id = @user.id
      @user_industry.industry_id = industryOne.id
      @user_industry.save!
      session['showIndustry'] = true

      get :index
      @questions = assigns(:questions)
      assert_equal(3, @questions.length)
    end

  test "When a question is modified, the previous version is retained within the system" do

    oldTitle = @question.qTitle

    put :update, id: @question, question: { qText: @question.qText, qTitle: 'New Title', status: @question.status }

    @questions = Question.unscoped.where("qTitle = ?", oldTitle)

    assert(@questions.count > 0)

  end

  test "When a question is modified, the version number is increased" do

    originalRev = @question.version
    put :update, id: @question, question: { qText: @question.qText, qTitle: 'New Title', status: @question.status }

    @question = Question.unscoped.find(@question.id)

    assert_not_equal(@question.version, originalRev)

  end

  test "When a new question is created, it is given a version number" do

    assert(@question.version = 1)

  end

  test "When a question is modified, only the most current version is displayed" do

    originalRev = @question.version
    put :update, id: @question, question: { qText: @question.qText, qTitle: 'New Title', status: @question.status }

    @question = Question.unscoped.find(@question.id)

    get(:index)

    @questions = assigns(:questions)

    assert_equal(@questions.count, 1)

  end

end
