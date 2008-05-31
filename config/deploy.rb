require 'mongrel_cluster/recipes'

set :application, "fb2twit"
set :deploy_to, "/mnt/#{application}"

set :mongrel_conf, "#{current_path}/config/mongrel_cluster.yml"

set :user, 'root'
set :password, nil

role :app, "haruska.dyndns.org"
role :web, "haruska.dyndns.org"
role :db,  "haruska.dyndns.org", :primary => true

after "deploy:stop", "stop_daemons"
before "deploy:start", "start_daemons"
before "deploy:restart", "restart_daemons"


desc "Starts background daemons"
task :start_daemons, :roles => :app do
  invoke_command "cd #{current_path} && RAILS_ENV=production script/daemons start"
end

desc "Stops background daemons"
task :stop_daemons, :roles => :app do
  invoke_command "cd #{current_path} && RAILS_ENV=production script/daemons stop"
  sleep 2 #wait for process to finish
end

desc "Restarts background daemons"
task :restart_daemons, :roles => :app do
  stop_daemons
  start_daemons
end
