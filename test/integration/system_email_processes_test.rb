require 'integration_test_helper'

describe 'System email process integration', js: true do

  it "Should permit administrators to  send system alerts to users" do
    Capybara.javascript_driver = :webkit
    authenticate_admin_user
    click_on 'Administration'
    click_on 'System Announcement'
    fill_in :subject, with: 'Test Announcement'
    fill_in :subject, with: 'This is a test announcement'
    click_on  'Send Announcement'

    assert page.has_content?('Announcement has been sent')
  end

  it "Should permit users to send messages to the administrator" do
    Capybara.javascript_driver = :webkit
    3.times do
      create(:adminUser)
    end
    authenticate_basic_user
    click_on 'Contact'
    fill_in :subject, with: 'Message to Admins'
    fill_in :message, with: 'This is a test message'
    click_on 'Send Message'
    assert page.has_content?('Message has been sent')
  end

end
