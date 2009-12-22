include_recipe "git"
include_recipe "rake"
include_recipe "www-data"
include_recipe "unicorn"
include_recipe "nginx::unicorn"
include_recipe "postgresql::server"
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

execute "create retrospectiva database user" do
  command "createuser --no-createdb --no-createrole --no-superuser retrospectiva && \
    psql --command \"alter role retrospectiva with encrypted password 'retrospectiva'\""
  user "postgres"
  not_if do 
    `sudo -u postgres psql --tuples-only --command=" \
      select rolname from pg_roles where \
      rolname = 'retrospectiva'"`.strip == "retrospectiva"
  end 
end

execute "create retrospectiva database" do
  command "createdb --owner=retrospectiva retrospectiva"
  user "postgres"
  not_if do 
    `sudo -u postgres psql --tuples-only --command=" \
      select datname from pg_database where \
      datname = 'retrospectiva'"`.strip == "retrospectiva"
  end  
end

template "/var/www/current/config/database.yml" do
  source "database.yml.erb"
  owner "www-data"
  group "www-data"
  mode "644"
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

