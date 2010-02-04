include_recipe "hyperic::default"

agent_home = node[:hyperic][:agent_home]

directory "/home/hyperic/.hq" do
  owner "hyperic"
  group "hyperic"
  mode "755"
  recursive true
  action :create
end

template "/home/hyperic/.hq/agent.properties" do
  source "agent.properties.erb"
  mode "644"
  owner "hyperic"
  group "hyperic"
  variables(
    :server => node[:hyperic][:server],
    :login => node[:hyperic][:login],
    :password => node[:hyperic][:password], 
    :ip => node[:hyperic][:ip])
end

link agent_home do
  to "#{agent_home}-#{node[:hyperic][:version]}"
end

remote_file "/home/hyperic/hyperic-hq-agent.tgz" do
  source node[:hyperic][:agent_uri]
  checksum node[:hyperic][:agent_checksum]
  owner "hyperic"
  group "hyperic"
end

execute "untar hyperic-hq-agent" do
  command "tar xzf hyperic-hq-agent.tgz"
  cwd "/home/hyperic"
  user "hyperic"
  group "hyperic"
  creates "#{agent_home}/bin/hq-agent.sh"  
end

template "/etc/init.d/hq-agent" do
  source "hq-agent-init.sh.erb"
  mode "755"
  owner "root"
  group "root"
end

service "hq-agent" do
  supports :start => true, :stop => true, :restart => true, :status => true
  action [:enable, :start]
end