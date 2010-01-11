package "memcached" do
  action :upgrade
end

remote_file "/etc/default/memcached" do
  source "memcached"
  owner "root"
  group "root"
  mode "644"
end

template "/etc/memcached.conf" do
  source "memcached.conf.erb"
  mode "644"
  owner "root"
  group "root"
  variables( :memory_mb => node[:memcached][:memory_mb].to_i)
end

service "memcached" do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end