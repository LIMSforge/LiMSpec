require 'test_helper'

class AdministrationControllerTest < ActionController::TestCase
  test "should get send announcements" do
    login_admin
    5.times do
      create(:user)
    end
    pendingMails = ActionMailer::Base.deliveries.size
    post :send_announce, :subtext => "Test Message", :announcement => "Shutdown"
    assert_not_equal(pendingMails, ActionMailer::Base.deliveries.size)
  end

  test "users with system notification set should receive email" do
    login_admin
    5.times do
      create(:user)
    end
    pendingMails = ActionMailer::Base.deliveries.size
    post :send_announce, :subtext => "Test Message", :announcement => "Shutdown"
    recipientCount = User.where(:emailSystemNotify => true).count
    assert_equal(recipientCount+pendingMails, ActionMailer::Base.deliveries.size)
  end

  test "administrator should be able to access the administration page" do
    login_admin
    get :display
    assert_response :success
  end

  test "non administrator should trigger error when attempting to access the administrative functions"  do
    login_editor
    get :display
    assert_redirected_to root_url
    assert(flash[:notice].include?("You are not allowed"))
  end

  test "Lowest authorization level can send contact messages" do
    login_admin
    5.times do
      create(:user)
    end
    login_reader
    pendingMails = ActionMailer::Base.deliveries.size
    post :contact, :subtext => "Test Admin Contact", :message => "Test Message"
    assert_not_equal(pendingMails, ActionMailer::Base.deliveries.size)

  end


end
