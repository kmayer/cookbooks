include_recipe "hyperic::default"
include_recipe "postgresql::server"
include_recipe "postgresql::create"

path = node[:hyperic][:server_install_path]

remote_file "/home/hyperic/hyperic-hq-server.tgz" do
  source node[:hyperic][:server_uri]
  checksum node[:hyperic][:server_checksum]
  owner "hyperic"
  group "hyperic"
end

execute "untar hyperic-hq-server" do
  cwd "/home/hyperic"
  command "tar xzf hyperic-hq-server.tgz"
  user "hyperic"
  group "hyperic"
  creates "#{path}/LICENSES.txt"
end

template "#{path}/server.properties" do
  source "server.properties.erb"
  mode "644"
  owner "hyperic"
  group "hyperic"
end

template "#{path}/setup.sh" do
  source "setup.sh.erb"
  mode "755"
  owner "hyperic"
  group "hyperic"
  ignore_failure true
end

execute "configure hyperic server" do
  command "sudo -u hyperic #{path}/setup.sh #{path}/server.properties"
  creates "/home/hyperic/server-4.2.0/README.txt"
end

template "/etc/init.d/hq-server" do
  source "hq-server-init.sh.erb"
  mode "755"
  owner "root"
  group "root"
end

service "hq-server" do
  supports :start => true, :stop => true
  action [:enable, :start]
end
