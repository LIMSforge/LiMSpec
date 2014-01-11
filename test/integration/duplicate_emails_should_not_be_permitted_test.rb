require 'integration_test_helper'

class DuplicateEmailsShouldNotBePermittedTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  before do
      original_session = Sunspot.session
      Sunspot.session = Sunspot::Rails::StubSessionProxy.new(original_session)
    end
    after do
      Sunspot.session = original_session
    end
  test "Creating new account with unique e-mail succeeds" do
     visit new_identity_path
     fill_in 'name', with: 'Test'
     fill_in 'email', with: 'new@email.com'
     fill_in 'password', with: 'Test1234'
     fill_in 'password_confirmation', with: 'Test1234'
     click_button 'Register'
     assert(page.has_content?('Logout'))

  end

  test "Creating new account with duplicate e-mail fails" do

    Capybara.javascript_driver = :selenium

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
