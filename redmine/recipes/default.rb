include_recipe "git"
include_recipe "www-data"
include_recipe "postfix"
include_recipe "ruby-enterprise-edition"
include_recipe "rake"
include_recipe "rails"
include_recipe "unicorn"
include_recipe "rmagick"
include_recipe "nginx::unicorn"
include_recipe "postgresql::server"
include_recipe "postgresql::create"
include_recipe "postgresql::ruby-pg"

execute "clone redmine" do
  command "git clone git://github.com/edavis10/redmine.git current"
  cwd "/var/www"
  creates "/var/www/current/README.rdoc"
  user "www-data"
end

template "/var/www/current/config/environment.rb" do
  source "environment.rb.erb"
  owner "www-data"
  group "www-data"
  mode "644"
  variables :session_secret => node[:redmine][:session_secret]
  notifies :restart, resources(:service => "unicorn")
end

template "/var/www/current/config/email.yml" do
  source "email.yml.erb"
  owner "www-data"
  group "www-data"
  mode "644"
  variables :email_domain => node[:redmine][:email_domain]
end

template "/var/www/current/config/database.yml" do
  source "database.yml.erb"
  owner "www-data"
  group "www-data"
  mode "644"
  variables( 
    :db_name => node[:postgresql][:db_name],
    :username => node[:postgresql][:username],
    :password => node[:postgresql][:password])
  notifies :restart, resources(:service => "unicorn")
end
