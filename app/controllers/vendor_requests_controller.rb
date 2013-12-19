
class VendorRequestsController < ApplicationController
 begin


  def produceRFP
    params[:reqFileName] = "LiMSpec_RFP"
    getRequirementArray
    getQuestionArray
    respond_to do |format|
      format.odt {send_open_document_file}
    end
  end

  def produceUserRFP
      params[:reqFileName] = "LiMSpec_RFP"
      @user_requirements = current_user.user_requirements.order('position')
      @user_questions = current_user.user_questions.order('position')
      respond_to do |format|
        format.odt {send_open_document_file}
      end
  end
 end
end

