set :deploy_to, '/var/www/production'
set :rails_env, 'production'
set :db_database, 'limspecProdDB'
#after "deploy:finalize_update", "deploy:SunspotIndex"
