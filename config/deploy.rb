set :application, "capi_app"
set :repository,  "git@github.com:jaipratik/capi_app.git"

set :scm, :git

set :user, "jp"
set :use_sudo, false
set :deploy_to, "/home/jp/sites/capi_app"


role :web, "192.168.2.129"                          # Your HTTP server, Apache/etc
role :app, "192.168.2.129"                          # This may be the same as your `Web` server
role :db,  "192.168.2.129", :primary => true # This is where Rails migrations will run
  

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

