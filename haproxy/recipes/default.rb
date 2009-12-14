package "haproxy" do
  action :upgrade
end

template "/etc/default/haproxy" do
  source "haproxy-default.erb"
  owner "root"
  group "root"
  mode 0644
end

directory "/usr/share/haproxy" do
  owner "root"
  group "root"
  mode 0755
  action :create
end

service "haproxy" do
  supports :restart => true, :status => true, :reload => true
  action [:enable, :start]
end

template "/etc/haproxy/haproxy.cfg" do
  source "haproxy.cfg.erb"
  owner "root"
  group "root"
  mode 0644
  variables :highest_port => node[:haproxy][:servers].to_i + 5000
  notifies :restart, resources(:service => "haproxy")
end