class UserMailer < ActionMailer::Base
  default from: "admin@limspec.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user

    mail to: user.email, subject: "Password Reset"
  end

  def system_announcement(user, subtext, announcetext)
     @user = user
      mail to: @user.email, subject: subtext do |format|
        format.text {render text: announcetext}
      end
  end

  def contact_message(user, replyemail, subtext, message)
     @user = user
     mail to:@user.email, subject: subtext, reply_to: replyemail do |format|
       format.text {render text: message}
     end
  end

  def new_account(user)
    @user = user
    mail to:user.email, subject: "Welcome to LiMSpec"
  end

  def account_reminder(user)
    @user = user
    mail to:user.email, subject: "LiMSpec Registration"
  end
end