
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

def FilteredQuestionList
  @product = Product.find(params[:prodID])
  idArray = @product.question_versions.pluck(:quest_id)
  if !params[:industry_id].nil? && !(params[:industry_id] == "")

     @questionList = Industry.find_by_id(params[:industry_id]).questions

  else

     @questionList = Question.all


  end
  if idArray.count == 0 || idArray.nil?
   @questions = @questionList
  else
    @questions = Array.new
    @questionList.all.each do |question|
      if !idArray.include?(question.id)
        @questions << question
      end
    end
  end


  render partial: "questionList"
end

def assign_questions
  @questions = Question.find(params[:question_ids])

  @questions.each do |question|

    @questVersion = QuestionVersion.find_by_quest_id_and_version(question.id, question.version)

    @product = Product.find(params[:id])

    @product.question_versions << @questVersion

    redirect_to product_path(@product)
  end

end

end
