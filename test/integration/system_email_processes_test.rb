require 'integration_test_helper'

class SystemEmailProcessesTest < ActionDispatch::IntegrationTest

  test "Administrators can send system alerts to users" do
    Capybara.javascript_driver = :selenium
    authenticate_admin_user
    visit(administer_path)
    fill_in :subject, with: 'Test Announcement'
    fill_in :subject, with: 'This is a test announcement'
    click_on  'Send Announcement'
    assert page.has_content?('Announcement has been sent')
  end

  test "Users can send messages to the administrator" do
    Capybara.javascript_driver = :selenium
    3.times do
      create(:adminUser)
    end
    authenticate_basic_user
    visit(contact_us_path)
    fill_in :subject, with: 'Message to Admins'
    fill_in :message, with: 'This is a test message'
    click_on 'Send Message'
    assert page.has_content?('Message has been sent')
  end

end
