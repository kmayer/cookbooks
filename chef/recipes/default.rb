service "chef-client" do
  supports :restart => true, :reload => true, :status => true
  action :disable
  only_if "test -f /etc/init.d/chef-client"
end

remote_file "/etc/chef/packages@opscode.com.gpg.key" do
  source "packages@opscode.com.gpg.key"
end

template "/etc/apt/sources.list.d/opscode.list" do
  source "opscode.list.erb"
end

execute "add opscode repository key" do
  command "apt-key add packages@opscode.com.gpg.key"
  cwd "/etc/chef"
  not_if "apt-key list | grep 83EF826A"
end

execute "update repository" do
  command "apt-get update"
  not_if "test -f /var/lib/apt/lists/apt.opscode.com_dists_karmic_Release"
end

execute "upgrade chef" do
  command "apt-get upgrade ohai chef -y"
  not_if "chef-solo --version | grep #{node[:chef][:version]}"
end