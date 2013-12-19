
class AdministrationController < ApplicationController
  skip_before_filter :require_auth

  def display
      if (current_user && current_user.role?(:Administrator))
        respond_to do |format|
          format.html
        end
      else
        redirect_to root_url, notice: "You are not allowed to access this feature."
      end
  end

  def contact_us
    respond_to do |format|
      format.html
    end
  end

  def send_announce
    if current_user.role?(:Administrator)
      @users =  User.where("users.email is not null and users.email <> ''").where(:emailSystemNotify => true)
      @users.each do |user|
        UserMailer.system_announcement(user, params[:subtext], params[:announcement]).deliver
      end
      redirect_to administer_path, notice: "Announcement has been sent"
    end
  end

  def contact
    @users = User.admins.where("users.email is not null")
    @users.each do |user|
      UserMailer.contact_message(user, current_user.email, params[:subtext], params[:message]).deliver
    end
    redirect_to contact_us_path, notice: "Message has been sent"
  end
end
