class OrganizationsController < InheritedResources::Base
  load_and_authorize_resource
  def create
     respond_to do |format|
           if @organization.save
             format.html { redirect_to @organization, notice: 'Response was successfully created.' }
             format.json { render json: @organization, status: :created, location: @organization }
           else
             format.html { render action: "new" }
             format.json { render json: @organization.errors, status: :unprocessable_entity }
           end
         end
  end

  def destroy

    Organization.find(params[:id]).destroy
    redirect_to organizations_path

  end

  def index
    respond_to do |format|
    format.js
    format.html # index.html.erb
    format.json { render json: @organizations }
  end
  end
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @organization }
    end
  end

  def update

  end
end
