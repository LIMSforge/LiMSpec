class UserRequirementsController < ApplicationController

  load_and_authorize_resource


  def index

    if params[:search]
      session[:search] = params[:search]
    end

    if ((session[:search]) && (session[:search]!=""))
          @search = UserRequirement.search do
            with(:user_id, current_user.id)
            fulltext params[:search]
            order_by :position
         end
          @user_requirements = @search.results
    else
          @user_requirements = UserRequirement.where('user_id = ?', current_user.id).order(:position)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_requirements }
    end
  end

  # GET /user_requirements/1
  # GET /user_requirements/1.json

  def updateSort

    params[:user_requirement].each_with_index do |id, index|
      userReq = UserRequirement.find(id)
      userReq.position = index+1
      userReq.save!
    end
    render nothing:true
  end


  def show


    @user_requirement = current_user.user_requirements.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_requirement }
    end
  end

  # GET /user_requirements/new
  # GET /user_requirements/new.json
  def new

    @user_requirement = UserRequirement.new
    @user_requirement.user_id = current_user.id
    if (current_user.user_requirements.count > 0)
          @user_requirement.position = current_user.user_requirements.maximum('position')+1
        else
          @user_requirement.position = 1
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_requirement }
    end
  end

  # GET /user_requirements/1/edit
  def edit

    @user_requirement = current_user.user_requirements.find(params[:id])
  end

  # POST /user_requirements
  # POST /user_requirements.json
  def create

    @user_requirement = UserRequirement.new(params[:user_requirement])
    @user_requirement.user_id = current_user.id


    if (current_user.user_requirements.count > 0)
      @user_requirement.position = current_user.user_requirements.maximum('position')+1
    else
      @user_requirement.position = 1
    end
    @user_requirement.save!

    respond_to do |format|
      if @user_requirement.save
        format.html { redirect_to @user_requirement, notice: 'User requirement was successfully created.' }
        format.json { render json: @user_requirement, status: :created, location: @user_requirement }
      else
        format.html { render action: "new" }
        format.json { render json: @user_requirement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_requirements/1
  # PUT /user_requirements/1.json
  def update

    @user_requirement = current_user.user_requirements.find(params[:id])

    #TODO need to detect when industry list has been modified
    respond_to do |format|

      if @user_requirement.update_attributes(params[:user_requirement])

        format.html { redirect_to @user_requirement, notice: 'User requirement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_requirement.errors, status: :unprocessable_entity }
      end
    end
  end


  def revert
    #Take a modified user requirement and revert it to an exact copy of the source requirement
    @noticeMessage = ''
    @user_requirement = current_user.user_requirements.find(params[:id])
    if !@user_requirement.nil?
      if @user_requirement.userModified?
        @requirement = Requirement.find(@user_requirement.requirement_id)
        if !@requirement.nil?
          @user_requirement.req_title = @requirement.reqTitle
          @user_requirement.req_text = @requirement.reqText
          @user_requirement.category_id = @requirement.category_id
          @user_requirement.userModified = false
          @user_requirement.ind_user_requirements.each do |iur|
            @ind_user_req = IndUserRequirement.find(iur.id)
            @ind_user_req.delete
          end
          @requirement.ind_requirements.each do |ir|
            @iur = IndUserRequirement.new()
            @iur.user_requirement_id = @user_requirement.id
            @iur.industry_id = ir.industry_id
            @iur.save
          end
          if @user_requirement.save
            @noticeMessage = 'User requirement was successfully reverted.'
            @user_requirement.update_column(:userModified, false)
          else
            @noticeMessage = 'Unable to save user requirement'

          end
        else
          @noticeMessage = 'Unable to save user requirement, original requirement could not be located'
        end
      end
    end
    respond_to do |format|
        format.html { redirect_to @user_requirement, notice: @noticeMessage}
    end
  end
  def destroy

    @user_requirement = current_user.user_requirements.find(params[:id])
    @user_requirement.destroy

    respond_to do |format|
      format.html { redirect_to user_requirements_url }
      format.json { head :no_content }
    end
  end

  def download_xml
      @user_requirements = current_user.user_requirements.order('position')

      send_data @user_requirements.to_xml, filename: 'UserRequirements.xml', skip_types: true, except: [:created_at, :updated_at, :category_id]
  end
end
