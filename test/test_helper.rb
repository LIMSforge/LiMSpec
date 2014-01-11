require File.expand_path('../../config/environment', __FILE__)

require 'rails/test_help'
require 'factory_girl_rails'
require 'database_cleaner'
require 'minitest/rails'
require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/mock'
ENV["RAILS_ENV"] = "test"
require 'rails/test_help'
DatabaseCleaner.strategy = :truncation
#require 'capybara/rails'
require 'webmock/test_unit'
include FactoryGirl::Syntax::Methods
require 'mocha/setup'



class ActiveSupport::TestCase

  setup do

    DatabaseCleaner.clean
        #OmniAuth.config.test_mode = true
        #OmniAuth.config.add_mock(:linkedin, {
        #  :uid => '12345',
        #  :email => 'test@test.com'
        #})
    @original_session = Sunspot.session
    Sunspot.session = Sunspot::Rails::StubSessionProxy.new(@original_session)
  end

  teardown do
    Sunspot.session = @original_session
  end

  def login_admin
    @user = FactoryGirl.create(:adminUser)
    session[:user_id] = @user.id
    @request.session[:last_seen] = Time.now
  end

  def login_editor
    @user = FactoryGirl.create(:editor)
    session[:user_id] = @user.id
    @request.session[:last_seen] = Time.now
  end

  def login_reader
    @user = FactoryGirl.create(:reader)
    session[:user_id] = @user.id
    @request.session[:last_seen] = Time.now
  end


  # Add more helper methods to be used by all tests here...
end
