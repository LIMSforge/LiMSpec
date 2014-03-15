class UserQuestionsController < ApplicationController

  load_and_authorize_resource

  # GET /user_questions
  # GET /user_questions.json
  def index
    if params[:search]
      session[:search] = params[:search]
    end
    if ((session[:search]) && (session[:search]!=""))
      @search = UserQuestion.search do
        with(:user_id, current_user.id)
        fulltext params[:search]
        order_by :position
``  end
      @user_questions = @search.results
    else
      @user_questions = UserQuestion.where('user_id = ?', current_user.id).order(:position)
    end


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_questions }
    end
  end

  # GET /user_questions/1
  # GET /user_questions/1.json
  def show
    @user_question = UserQuestion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_question }
    end
  end

  # GET /user_questions/new
  # GET /user_questions/new.json
  def new
    @user_question = UserQuestion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_question }
    end
  end

  # GET /user_questions/1/edit
  def edit
    @user_question = UserQuestion.find(params[:id])
  end

  # POST /user_questions
  # POST /user_questions.json
  def create
    @user_question = UserQuestion.new(params[:user_question])
    @user_question.user_id = current_user.id

    if (current_user.user_questions.count > 0)
          @user_question.position = current_user.user_questions.maximum('position').nil? ? 1 : current_user.user_questions.maximum('position')+1
        else
          @user_question.position = 1
        end
    @user_question.save!

    respond_to do |format|
      if @user_question.save
        format.html { redirect_to @user_question, notice: 'User question was successfully created.' }
        format.json { render json: @user_question, status: :created, location: @user_question }
      else
        format.html { render action: "new" }
        format.json { render json: @user_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_questions/1
  # PUT /user_questions/1.json
  def update
    @user_question = UserQuestion.find(params[:id])

    respond_to do |format|
      if @user_question.update_attributes(params[:user_question])
        format.html { redirect_to @user_question, notice: 'User question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_questions/1
  # DELETE /user_questions/1.json
  def destroy
    @user_question = UserQuestion.find(params[:id])
    @user_question.destroy

    respond_to do |format|
      format.html { redirect_to user_questions_url }
      format.json { head :no_content }
    end
  end

  def revert
  #Take a modified user requirement and revert it to an exact copy of the source requirement
      @noticeMessage = ''
      @user_question = current_user.user_questions.find(params[:id])
      if !@user_question.nil?
        if @user_question.userModified?
          @question = Question.find_by_id_and_version(@user_question.question_id, @user_question.version)
          if !@question.nil?
            @user_question.qTitle = @question.qTitle
            @user_question.qText = @question.qText
            @user_question.userModified = false

            if @user_question.save
              @noticeMessage = 'User question was successfully reverted.'
              @user_question.update_column(:userModified, false)
            else
              @noticeMessage = 'Unable to save user question'

            end
          else
            @questVersion = QuestionVersion.find_by_quest_id_and_version(@user_question.question_id, @user_question.version)
            if !@questVersion.nil?
              @user_question.qTitle = @questVersion.qTitle
              @user_question.qText = @questVersion.qText
              @user_question.userModified = false

              if @user_question.save
                @noticeMessage = 'User question was successfully reverted.'
                @user_question.update_column(:userModified, false)
              else
                @noticeMessage = 'Unable to save user question'

              end
            else
              @noticeMessage = 'Unable to save user question, original question could not be located'
            end

          end
        end
      end
      respond_to do |format|
          format.html { redirect_to @user_question, notice: @noticeMessage}
      end
  end

  def updateSort

        params[:user_question].each_with_index do |id, index|
        userQuest = UserQuestion.find(id)
        userQuest.position = index+1
        userQuest.save!
      end
      render nothing:true
  end

  def download_xml
    @user_questions = current_user.user_questions.order('position')
      send_data @requirements.to_xml, filename: 'User_Questions.xml', skip_types: true, except: [:created_at, :updated_at]
  end
end
