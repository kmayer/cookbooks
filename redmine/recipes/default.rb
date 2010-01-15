include_recipe "www-data"
include_recipe "postfix"
include_recipe "ruby-enterprise-edition"
include_recipe "rake"
include_recipe "unicorn"
include_recipe "rmagick"
include_recipe "nginx::unicorn"
include_recipe "postgresql::server"
include_recipe "postgresql::create"
include_recipe "postgresql::ruby-pg"

remote_file "/var/www/releases/redmine-0.9.0.tar.gz" do
  source "http://rubyforge.org/frs/download.php/68515/redmine-0.9.0.tar.gz"
  checksum "1117365d"
end

execute "untar redmine" do
  command "tar xzf redmine-0.9.0.tar.gz"
  creates "/var/www/releases/redmine-0.9.0/README.rdoc"
  cwd "/var/www/releases"
  user "www-data"
  group "www-data"
  action :run
end

link "/var/www/current" do
  to "/var/www/releases/redmine-0.9.0"
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