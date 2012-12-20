require 'bundler/capistrano'
require 'sidekiq/capistrano'

set :application, "taiwan_realtime_news_rails"
set :rails_env, "production"

set :repository,  "https://github.com/StevenKo/taiwan_realtime_news_server.git"
set :scm, "git"
set :user, "apps" # 一個伺服器上的帳戶用來放你的應用程式，不需要有sudo權限，但是需要有權限可以讀取Git repository拿到原始碼
set :port, "222"


set :deploy_to, "/home/apps/taiwan_realtime_news_rails"
set :deploy_via, :remote_cache
set :use_sudo, false

role :web, "106.187.102.146"
role :app, "106.187.102.146"
role :db,  "106.187.102.146", :primary => true

set :default_environment, {
    'PATH' => "/opt/ruby/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"
}

set :assets_dependencies, %w(app/assets lib/assets vendor/assets Gemfile.lock config/routes.rb)


namespace :deploy do
  

  task :copy_config_files  do
    db_config = "#{shared_path}/config/database.yml.production"
    run "cp #{db_config} #{release_path}/config/database.yml"
  end
  
  task :update_symlink do
    run "ln -s {shared_path}/public/system {current_path}/public/system"
  end
  
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

end

after "deploy:update_code", "deploy:copy_config_files" # 如果將database.yml放在shared下，請打開
