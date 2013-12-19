class ApplicationController < ActionController::Base

  rescue_from CanCan::AccessDenied do |exception|
      redirect_to root_url, :alert => exception.message
  end

  include ::OpenDocumentCompressor
  include RequirementsHelper
  protect_from_forgery

  before_filter :require_auth
  helper_method :current_user
  helper_method :signed_in?
  helper_method :getRequirementArray
  helper_method :getQuestionArray


  private

     def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]

      end

      def current_user=(user)
        @current_user = user
        session[:user_id] = user.nil? ? user : user.id
      end

      def signed_in?
        !!current_user
      end

      def require_auth
        unless signed_in?
          session[:original_dest] = request.fullpath || nil unless session[:original_dest]
          session[:original_dest] = request.referer || nil unless session[:original_dest]
          flash.keep
          redirect_to controller: :sessions, action: :new
        else
          redirect_to logout_path if session[:last_seen] < 10.minutes.ago
          session[:last_seen] = Time.now
        end
      end

     def getRequirementArray
      if params[:catSearch]
        session[:catSearch] = params[:catSearch]
      end
      if params[:search]
        session[:search] = params[:search]
      end

      @user = current_user
      @requirements = Requirement.catFilter(session[:catSearch])
      @requirements = @requirements.all
      if (session[:showIndustry])
            indArray = @user.industries.collect{|industry| industry.indName}
            @requirements = @requirements & Requirement.only_ind_reqs(indArray)
      end
      if ((session[:search]) && (session[:search]!=""))
        @search = Requirement.search do
          fulltext session[:search]
        end
        @requirements = @requirements & @search.results
      end
       if params[:controller] != "vendor_requests"
        @requirements = Kaminari.paginate_array(@requirements).page(params[:page]).per(10)
       end
     end

  def getQuestionArray

    if params[:search]
            session[:search] = params[:search]
    end
    @questions = Question.all

      @user = current_user
      if (session[:showIndustry])
          indArray = @user.industries.collect{|industry| industry.indName}
          @questions = @questions & Question.industry_questions(indArray)
      end
      if ((session[:search]) && (session[:search]!=""))
            @search = Question.search do
              fulltext session[:search]
            end
            @questions = @questions & @search.results
      end

      if params[:controller] != "vendor_requests"
        @questions = Kaminari.paginate_array(@questions).page(params[:page]).per(10)
      end

    end



end
