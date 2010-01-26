remote_file "/etc/chef/packages@opscode.com.gpg.key" do
  source "packages@opscode.com.gpg.key"
end

template "/etc/apt/sources.list.d/opscode.list" do
  source "opscode.list.erb"
end

execute "add opscode repository key and update apt sources" do
  command "apt-key add packages@opscode.com.gpg.key && apt-get update"
  cwd "/etc/chef"
  not_if "apt-key list | grep 83EF826A"
end

=begin

# this is a half-baked idea.
# apparently chef doesn't like being upgraded while running.
# suppose that part needs to be hand cranked for now.

execute "upgrade chef" do
  command "apt-get upgrade ohai chef -y"
  not_if "chef-solo --version | grep #{node[:chef][:version]}"
end

=end