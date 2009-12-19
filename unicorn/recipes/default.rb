gem_package "unicorn" do
  action :upgrade
end

directory "/etc/unicorn" do
  owner "root"
  group "root"
  mode 0755
  action :create
end

remote_file "/etc/unicorn/app.rb" do
  source "unicorn.rb"
  owner "root"
  group "root"
  mode 0644
end

remote_file "/etc/init.d/unicorn" do
  source "unicorn-init.sh"
  owner "root"
  group "root"
  mode 0755
end

service "unicorn" do
  supports :start => true, :restart => true, :stop => true
  action [ :enable, :start ]
end