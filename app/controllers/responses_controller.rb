class ResponsesController < InheritedResources::Base
  load_and_authorize_resource
 def create
   respond_to do |format|
         if @response.save
           format.html { redirect_to @response, notice: 'Response was successfully created.' }
           format.json { render json: @response, status: :created, location: @response }
         else
           format.html { render action: "new" }
           format.json { render json: @response.errors, status: :unprocessable_entity }
         end
       end
 end
end
