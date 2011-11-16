require 'bundler/capistrano'
#using  RVM!
$:.unshift("#{ENV["HOME"]}/.rvm/lib")
require "rvm/capistrano"
set :rvm_type, :user


set :application, "capi_app"
set :deploy_to, "/var/www/#{application}"

role :web, "50.18.154.22"                          # Your HTTP server, Apache/etc
role :app, "50.18.154.22"                          # This may be the same as your `Web` server
role :db,  "50.18.154.22", :primary => true # This is where Rails migrations will run


default_run_options[:pty] =  true
set :repository,  "git@github.com:jaipratik/capi_app.git"
set :scm, :git
set :branch, "master"


set :user, "ubuntu"            #if error use whats shown in podcast
set :use_sudo, false
set :admin_runner, "ubuntu"

#set :use_sudo, false   #if error delete this

server_endpoint: ec2-50-18-154-22.us-west-1.compute.amazonaws.com
  
  # REQUIRED The amazon keys and account ID (digits only, no dashes) used to access the AWS API
  #
  access_key: AKIAIHRM3ONTGJE4WP6Q
  secret_access_key: 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
  account: 893274982995
  
  

key_name: jpkey-keypair
key_file: "#{Dir[(File.expand_path('~') rescue '/root') + '/.ec2/*' + cloud_providers.aws.key_name].first}"



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
