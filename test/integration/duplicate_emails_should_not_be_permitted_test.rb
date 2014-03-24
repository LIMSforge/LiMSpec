require 'integration_test_helper'

describe "Email integration" do

  it "should create new account with unique e-mail" do
     authenticate_admin_user
     visit new_identity_path
     fill_in 'name', with: 'Test'
     fill_in 'email', with: 'new@email.com'
     fill_in 'password', with: 'Test1234'
     fill_in 'password_confirmation', with: 'Test1234'
     click_button 'Register'
     assert(page.has_content?('Logout'))

  end

  it "should not create new account with duplicate e-mail" do

    Capybara.javascript_driver = :selenium
    authenticate_admin_user
    visit new_identity_path

    fill_in 'name', with: 'Test'
    fill_in 'email', with: 'george@jungle.com'
    fill_in 'password', with: 'Test1234'
    fill_in 'password_confirmation', with: 'Test1234'
    click_button 'Register'
    visit logout_path
    visit new_identity_path
    fill_in 'name', with: 'Test'
    fill_in 'email', with: 'george@jungle.com'
    fill_in 'password', with: 'Test1234'
    fill_in 'password_confirmation', with: 'Test1234'
    click_button 'Register'
    assert(page.has_content?('Email has already been taken'))

  end
end
