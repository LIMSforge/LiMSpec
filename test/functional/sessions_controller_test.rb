require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  SessionsController.skip_before_filter :require_auth

end
