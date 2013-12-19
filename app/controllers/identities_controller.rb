
class IdentitiesController < ApplicationController
  skip_before_filter :require_auth

  def new
    @identity = env['omniauth.identity']
  end
end
