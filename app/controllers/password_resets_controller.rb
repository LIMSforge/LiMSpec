
class PasswordResetsController < ApplicationController
  skip_before_filter :require_auth
    def new

    end
    def create
      user = User.find_by_email(params[:email])
      if user
        if user.authentications.where(:provider => 'identity').count != 0
         user.send_password_reset
        end
      end
      redirect_to root_url, :notice => "Email sent with password reset instructions."
    end

    def edit
      @user = User.find_by_password_reset_token!(params[:id])
      @identity = Identity.find_by_email(@user.email)
      #@identity = Identity.find(@user.id)
    end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    @identity = Identity.find_by_email(@user.email)
    #@identity = Identity.find(@user.uid)
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password &crarr;
        reset has expired."
    elsif @identity.update_attributes(params[:identity])
      redirect_to root_url, flash[:notice] => "Password has been reset."
    else
      render :edit
    end
  end
end
