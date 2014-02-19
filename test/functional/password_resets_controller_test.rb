require 'test_helper'

class PasswordResetsControllerTest < ActionController::TestCase
  def create_user
        @user = create(:user)
        @authentication = create(:authentication)
        @authentication.provider = 'identity'
        @authentication.user_id = @user.id
        @authentication.save!
        @identity = build(:identity, email: @user.email)
        @identity.save(validate: false)
  end
  test "should email password reset request to user" do
    create_user
    pendingMails = ActionMailer::Base.deliveries.size
    post :create, {:email => @user.email}
    assert_not_equal(ActionMailer::Base.deliveries.size, pendingMails)
  end

  test "should indicate password reset sent if user does not exist" do
    post :create, {:email => 'blank@nonvalid.com'}
    assert(flash[:notice].include?("Email sent with password reset instructions."))
  end

  test "should not send email for user without identity authentication method" do
    @user = create(:user)
    @authentication = create(:authentication)
    @authentication.provider = 'linkedin'
    @authentication.user_id = @user.id
    @authentication.save!
    pendingMails = ActionMailer::Base.deliveries.size
    post :create, {:email => @user.email}
    assert_equal(ActionMailer::Base.deliveries.size, pendingMails)
  end

  test "should not send email to user that does not exist in system" do
    pendingMails = ActionMailer::Base.deliveries.size
    post :create, {:email => 'blank@nonvalid.com'}
    assert_equal(ActionMailer::Base.deliveries.size, pendingMails)
  end

  test "should generate valid password reset token" do
    create_user
    post :create, {:email => @user.email}
    @user = User.find_by_email(@user.email)
    resetToken = @user.password_reset_token
    get :edit, :id => resetToken
    assert_response :success
  end
  test "should not permit reset with expired password reset token" do
    create_user
    post :create, {:email => @user.email}
    @user = User.find_by_email(@user.email)
    @user.password_reset_sent_at = Time.zone.now.ago(10800)
    @user.save(:validate => false)
    resetToken = @user.password_reset_token
    post :update, :id => resetToken
    assert_redirected_to new_password_reset_path
  end

  test "should update password with valid reset token" do
    create_user
    post :create, {:email => @user.email}
    @user = User.find_by_email(@user.email)
    @identity = Identity.find_by_email(@user.email)
    resetToken = @user.password_reset_token
    post :update, :id => resetToken, :identity => {:id => @identity.id, :name=> 'Foo Bar', :password => 'Test_1234', :password_confirmation => 'Test_1234'}
    assert_redirected_to root_url
  end

  test "should require another password if new password fails validation" do
    create_user
    post :create, {:email => @user.email}
    @user = User.find_by_email(@user.email)
    @identity = Identity.find_by_email(@user.email)
    resetToken = @user.password_reset_token
    post :update, :id => resetToken, :identity => {:id => @identity.id, :name => 'Foo Bar', :password => 'Test', :password_confirmation => 'Test'}
    assert_response :success #staying on the same page, hence rendering the edit view.
  end
end
