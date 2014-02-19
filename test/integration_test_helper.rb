require 'simplecov'
#require 'rails/test_help'
#require 'minitest/autorun'  after upgrade to rubymine 6, this seemed to trigger an error
require 'minitest/spec'
ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
DatabaseCleaner.strategy = :truncation
require 'capybara/rails'
require 'mocha/setup'
include FactoryGirl::Syntax::Methods

WebMock.disable_net_connect!(:allow_localhost => true)

class ActionDispatch::IntegrationTest

  include Capybara::DSL
  self.use_transactional_fixtures = false

  setup do

    @adminUser = FactoryGirl.create(:adminUser)
    @adminUser.uid = @adminUser.id
    @adminUser.save
    authentication = FactoryGirl.create(:authentication)
    authentication.uid = @adminUser.uid
    authentication.provider = 'identity'
    authentication.user_id = @adminUser.id
    authentication.save
    identity = FactoryGirl.create(:identity)
    identity.name = @adminUser.name
    identity.email = @adminUser.email
    identity.save


    @basicUser = FactoryGirl.create(:user)
    @basicUser.uid = @basicUser.id
    @basicUser.save
    authentication = FactoryGirl.create(:authentication)
    authentication.uid = @basicUser.uid
    authentication.provider = 'identity'
    authentication.user_id = @basicUser.id
    authentication.save
    identity = FactoryGirl.create(:identity)
    identity.name = @basicUser.name
    identity.email = @basicUser.email
    identity.save

  end

  def authenticate_admin_user

        visit '/sessions/new'
        fill_in 'auth_key', with: @adminUser.email
        fill_in 'password', with: 'fooBar_1'
        click_button 'Login'

  end

  def authenticate_basic_user

    visit '/sessions/new'
    fill_in 'auth_key', with: @basicUser.email
    fill_in 'password', with: 'fooBar_1'
    click_button 'Login'

  end


  teardown do

    DatabaseCleaner.clean
    Capybara.reset_sessions!
    Capybara.use_default_driver

  end
end