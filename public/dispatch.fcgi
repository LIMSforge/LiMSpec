#!/home/jleecbd/.rvm/rubies/ruby-1.9.3-p194/bin/ruby

ENV['GEM_HOME'] = '/home/jleecbd/shared/bundle/ruby/1.9.1/gems'
ENV['RAILS_ENV'] = 'production'

require '/home/jleecbd/limspec.infosynergetics.com/current/config/environment'

class Rack::PathInfoRewriter
  def initialize(app)
    @app = app
  end

  def call(env)
    env.delete('SCRIPT_NAME')
    parts = env['REQUEST_URI'].split('?')
    env['PATH_INFO'] = parts[0]
    env['QUERY_STRING'] = parts[1].to_s
    @app.call(env)
  end
end

Rack::Handler::FastCGI.run  Rack::PathInfoRewriter.new(Limspec::Application)
