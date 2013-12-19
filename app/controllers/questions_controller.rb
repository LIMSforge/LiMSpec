
class QuestionsController < InheritedResources::Base

  load_and_authorize_resource

  def change_industry_setting
      session[:showIndustry] = !session[:showIndustry]
      respond_to do |format|
        format.html {redirect_to questions_url}
      end
  end

  # GET /questions
  # GET /questions.json

  def index
    session['review'] = false
    getQuestionArray
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @questions }
    end
  end

  def review
    session['review'] = true
    @questions = Question.submitted
    @questions = Kaminari.paginate_array(@questions).page(params[:page]).per(10)
    respond_to do |format|
      format.html {render :index}
    end
  end

  # GET /questions/new
  # GET /questions/new.json
  def new
    if (can? :approve, @question)
      @question.status = 'Public'
    else
      @question.status = 'Submitted'
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @question }
    end
  end


  # POST /questions
  # POST /questions.json
  def create
    if (can? :approve, @question)
              @question.status = 'Public'
            else
              @question.status = 'Submitted'
    end

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render json: @question, status: :created, location: @question }
      else
        format.html { render action: "new" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end


  # PUT /questions/1
  # PUT /questions/1.json
  def update

    params[:question][:industry_ids] ||= []

    respond_to do |format|

      if @question.update_attributes(params[:question])
        if (params['Submit_for_Approval']) and (@question.status !='Submitted')
          flash[:error]='Could not submit question for approval'
        end
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end
  def change_selected_questions
      @questions = Question.find(params[:question_ids])
      @questions.each do |question|
        if !(question.copied_by_me?(current_user))
          UserQuestion.createUserQuestion(current_user, question)
        end

      end
      getQuestionArray
      respond_to do |format|
        format.html {render action: "index"}
      end
    end

  def download_xml
    getQuestionArray
    send_data @questions.to_xml, filename: 'Questions.xml', skip_types: true, except: [:created_at, :updated_at]
  end

end
