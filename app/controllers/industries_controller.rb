
class IndustriesController < InheritedResources::Base

  load_and_authorize_resource

  def create
     respond_to do |format|
           if @industry.save
             format.html { redirect_to @industry, notice: 'Response was successfully created.' }
             format.json { render json: @industry, status: :created, location: @industry }
           else
             format.html { render action: "new" }
             format.json { render json: @industry.errors, status: :unprocessable_entity }
           end
         end
   end
end
