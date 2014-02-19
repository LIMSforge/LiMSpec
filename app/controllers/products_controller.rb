
class ProductsController < InheritedResources::Base

  load_and_authorize_resource

def create
  respond_to do |format|
            if @product.save
              format.html { redirect_to @product, notice: 'Product was successfully created.' }

            else
              format.html { render action: "new" }

            end
  end
end



end
