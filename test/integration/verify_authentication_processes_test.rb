require 'integration_test_helper'

describe "Authentication processes integration" do

  it "Should not authenticate an incorrect password" do
     visit('/sessions/new')
     fill_in 'auth_key', with: 'foobar@example.com'
     fill_in 'password', with: 'Wrong_Password'
     click_button 'Login'
     assert page.has_content?('Sign In') #redirected back to login page
  end

  it "Should log in a correct password" do
    authenticate_admin_user
    assert page.has_content?('Requirements')
  end

  it "Should send user back to authentication screen when logging out" do
    authenticate_admin_user
    assert page.has_content?('Requirements')
    click_link('Logout')
    assert page.has_content?('Sign In')
    assert !page.has_content?('Requirements')
  end

  it "Should create new user with identity" do
    visit('/sessions/new')
    click_on('Create an account')
    fill_in 'name', with: 'Test User'
    fill_in 'email', with: 'testuser@infosynergetics.com'
    fill_in 'password', with: 'Test1234'
    fill_in 'password_confirmation', with: 'Test1234'
    assert !page.has_content?('Logout')
  end

  it "Should not allow users to access administration functions without authorization" do
      authenticate_basic_user
      visit(create_system_announcement_path)
      save_and_open_page
      assert page.has_content?('You are not allowed')
  end

end
