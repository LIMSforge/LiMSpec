require 'integration_test_helper'

class VerifyAuthenticationProcessesTest < ActionDispatch::IntegrationTest
  test "Incorrect password should not be authenticated" do
     visit('/sessions/new')
     fill_in 'auth_key', with: 'foobar@example.com'
     fill_in 'password', with: 'Wrong_Password'
     click_button 'Login'
     assert page.has_content?('Sign In') #redirected back to login page
  end

  test "Correct password logs in" do
    authenticate_admin_user
    assert page.has_content?('Requirements')
  end

  test "Logging out sends user back to authentication screen" do
    authenticate_admin_user
    assert page.has_content?('Requirements')
    click_link('Logout')
    assert page.has_content?('Sign In')
    assert !page.has_content?('Requirements')
  end

  test "Create new user with identity" do
    visit('/sessions/new')
    click_on('Create an account')
    fill_in 'name', with: 'Test User'
    fill_in 'email', with: 'testuser@infosynergetics.com'
    fill_in 'password', with: 'Test1234'
    fill_in 'password_confirmation', with: 'Test1234'
    assert !page.has_content?('Logout')
  end

  test "Users cannot access administration functions without authorization" do
      authenticate_basic_user
      visit(administer_path)
      assert page.has_content?('You are not allowed')
  end

end
