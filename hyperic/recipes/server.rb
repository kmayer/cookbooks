include_recipe "hyperic::default"
include_recipe "postgresql::server"
include_recipe "postgresql::create"

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
  creates "/home/hyperic/hyperic-hq-installer/LICENSES.txt"
end

=begin

# install hyperic server. need a non-interactive way to do this.

sudo -u hyperic -s -H
JAVA_HOME=/usr /home/hyperic/hyperic-hq-installer/setup.sh -postgresql
JAVA_HOME=/usr server-4.2.0/bin/hq-server.sh start

# startup isn't working yet. the follow should be included
if test -f /etc/default/hq-server; then
    . /etc/default/hq-server
fi

=end

template "/etc/default/hq-server" do
  source "hq-server.erb"
  mode "644"
  owner "root"
  group "root"
  variables :path => "/home/hyperic/server-#{node[:hyperic][:version]}"
end

link "/etc/init.d/hq-server" do
  to "/home/hyperic/server-#{node[:hyperic][:version]}/bin/hq-server.sh"
end

service "hq-server" do
  supports :start => true, :stop => true
  action :enable
end