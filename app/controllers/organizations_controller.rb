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
end
