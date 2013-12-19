class SessionsController < ApplicationController
  skip_before_filter :require_auth
  def new

  end

  def create
    auth = request.env['omniauth.auth']

    @authentication = Authentication.find_with_omniauth(auth)

    if @authentication.nil?
      @authentication = Authentication.create_with_omniauth(auth)
    end
    if signed_in?
        session[:last_seen] = Time.now
      if @authentication.user == current_user
        redirect_to root_path, notice: "You have already linked this account"
      else
        @authentication.user = current_user
        @authentication.save
        redirect_to root_path, notice: "Account successfully authenticated"
      end
      else
        if @authentication.user.present?
          session[:user_id] = @authentication.user.id
          session[:last_seen] = Time.now
          if session[:original_dest]

              redirect_to session[:original_dest]

          else

              redirect_to root_path

          end

        else
          if (@authentication.provider == 'identity') && (!User.where(id: @authentication.uid).empty?)

                    u = User.find(@authentication.uid)

          else

                    u = User.create_with_omniauth(auth)

          end
          u.authentications << @authentication
          session[:user_id]= u.id
          session[:last_seen] = Time.now
          redirect_to root_path
        end

    end
    #set app setting session variables and user industries

  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out."
  end

  def failure
    redirect_to root_url, notice: "Authentication failed, please try again."
  end
end