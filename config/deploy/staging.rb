set :deploy_to, '/var/www/test'
set :rails_env, 'staging'
set :db_database, 'limspecDB'
#after "deploy:finalize_update", "deploy:SunspotIndex"