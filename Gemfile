ruby '2.0.0'
source 'https://rubygems.org'

gem 'rails'
gem 'rdoc'
gem 'sqlite3', :group => [:development, :test]
gem 'cancan'
gem 'kaminari'
gem 'inherited_resources'
gem 'sunspot_rails'
gem 'capistrano', '~>2.2'
gem 'rvm-capistrano', '1.2.3'
gem 'paperclip', '~> 3.1'
# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'jquery-rails'
  gem 'jquery-ui-rails'


gem 'uglifier', '>= 1.0.3'

end

gem 'ranked-model'
gem 'doorkeeper', '~>0.7.0'
gem "oauth2"

gem 'bcrypt-ruby', '~> 3.0.0'

gem 'omniauth-identity'
gem 'omniauth-linkedin'
gem 'omniauth-openid'
gem 'omniauth-twitter'

gem 'csv_builder'
gem 'rubyzip', '~>0.9.9'

group :development do

  gem "railroady"
  gem "sunspot_solr"


end

group :production do
  gem 'libv8', '~> 3.11.8'
  gem 'therubyracer'
  gem 'mysql2'
end

group :test do

  gem 'factory_girl_rails'

  gem "sunspot_solr"
  gem "sunspot_test"
  gem 'capybara_minitest_spec'
  gem 'capybara', '~> 1.1.3'
  gem 'minitest-rails'
  gem 'minitest-rails-capybara', '0.1'
  gem 'minitest-reporters'
  gem 'database_cleaner', '<= 1.0.1'
  gem 'mocha', :require => false #allow the use of mocks without using RSpec
  gem 'simplecov'
  gem 'launchy'
  gem 'webmock'
  #gem 'capybara-webkit'


end

