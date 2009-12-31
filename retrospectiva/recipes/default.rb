include_recipe "git"
include_recipe "rake"
include_recipe "www-data"
include_recipe "postfix"
include_recipe "unicorn"
include_recipe "nginx::unicorn"
include_recipe "postgresql::server"
include_recipe "postgresql::create"
include_recipe "postgresql::ruby-pg"

%w(rails will_paginate acts-as-taggable-on RedCloth).each do |g|
  gem_package g do
    action :upgrade
  end
end

execute "clone retrospectiva" do
  command "git clone git://github.com/dim/retrospectiva.git /var/www/current"
  creates "/var/www/current/README"
  user "www-data"
  group "www-data"
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

execute "setup retrospectiva database" do
  command "rake RAILS_ENV=production db:setup"
  cwd "/var/www/current"
  user "www-data"
  not_if do `sudo -u postgres psql --tuples-only --command=" \
    select tablename from pg_tables \ 
    where tablename = 'tickets'" retrospectiva`.strip == "tickets"
  end
end