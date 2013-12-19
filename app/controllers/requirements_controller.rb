
class RequirementsController < InheritedResources::Base

  load_and_authorize_resource

  def destroy
    Requirement.find(params[:id]).destroy
    @userReqs = UserRequirement.where("requirement_id = ?", params[:id])
    @userReqs.each do |userReq|
      userReq.requirement_id = 0
      userReq.save!
    end
    redirect_to requirements_path
  end
  def change_industry_setting
    session[:showIndustry] = !session[:showIndustry]
    respond_to do |format|
      format.html {redirect_to requirements_url}
    end
  end

  # GET /requirements
  # GET /requirements.json
  def index
    session['review'] = false
    getRequirementArray
    @categories = Category.all
      respond_to do |format|
      format.js
      format.html # index.html.erb
      format.json { render json: @requirements }
    end
  end


  # GET /requirements/new
  # GET /requirements/new.json
  def new
    #TODO This needs to be rethought.  All requirements for most users should start life as a user_requirement? Unless an admin?


    @requirement.status = 'Public'

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @requirement }
    end
  end

  # POST /requirements
  # POST /requirements.json
  def create

    if current_user.role?('Admin')
      @requirement.status = 'Public'
    else
      @requirement.status = 'Submitted'
    end


    respond_to do |format|
      if @requirement.save
        UserRequirement.createUserRequirement(current_user, @requirement)
        format.html { redirect_to @requirement, notice: 'Requirement was successfully created.' }
        format.json { render json: @requirement, status: :created, location: @requirement }
      else
        format.html { render action: "new" }
        format.json { render json: @requirement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /requirements/1
  # PUT /requirements/1.json
  def update

    params[:requirement][:industry_ids] ||= []
    if params['Submit_for_Approval']
        @requirement.status = 'Submitted'
    end
    if params[:requirement][:status] == "Rejected"
      Requirement.destroy(params[:id])
      redirect_to requirements_path
    else
      respond_to do |format|
            if @requirement.update_attributes(params[:requirement])
              if (params['Submit_for_Approval']) and (@requirement.status != 'Submitted')
                flash[:error] = 'Could not submit requirement for approval'
              end
              format.html { redirect_to @requirement, notice: 'Requirement was successfully updated.' }
              format.json { head :no_content }
            else
              format.html { render action: "edit" }
              format.json { render json: @requirement.errors, status: :unprocessable_entity }
            end
          end
    end

  end


  def review
    session['review']= true
    @requirements = Requirement.submitted
    @requirements = Kaminari.paginate_array(@requirements).page(params[:page]).per(10)

    respond_to do |format|
      format.js {render action: "index"}
      format.html {render action: "index"}
    end
  end

  def download_xml
    getRequirementArray
    send_data @requirements.to_xml, filename: 'Requirements.xml', skip_types: true, except: [:created_at, :updated_at, :category_id]
  end


  def change_selected_requirements
    @requirements = Requirement.find(params[:requirement_ids])
    @requirements.each do |requirement|

    UserRequirement.createUserRequirement(current_user, requirement)

    end
    getRequirementArray
    respond_to do |format|
      format.html {render action: "index"}
    end
  end


end
