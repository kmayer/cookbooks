package "memcached" do
  action :upgrade
end

template "/etc/memcached.conf" do
  source "memcached.conf.erb"
  mode "644"
  owner "root"
  group "root"
  variables( :memory_mb => node[:memcached][:memory_mb].to_i)
end