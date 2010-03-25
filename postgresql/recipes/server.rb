include_recipe "postgresql::client"

package "postgresql" do
  action :upgrade
end

service "postgresql-8.4" do
  supports :restart => true, :status => true, :reload => true
  action :enable
end

template "/etc/postgresql/8.4/main/postgresql.conf" do
  source "postgresql.conf.erb"
  owner "postgres"
  group "postgres"
  mode "640"
  notifies :reload, resources(:service => "postgresql-8.4")
end

template "/etc/postgresql/8.4/main/pg_hba.conf" do
  source "pg_hba.conf.erb"
  owner "postgres"
  group "postgres"
  mode "640"
  notifies :reload, resources(:service => "postgresql-8.4")
  variables( 
    :username => node[:postgresql][:username]
    )
end

