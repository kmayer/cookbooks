gem_package "unicorn" do
  action :upgrade
end

directory "/etc/unicorn" do
  owner "root"
  group "root"
  mode "755"
  action :create
end

remote_file "/etc/unicorn/app.rb" do
  source "unicorn.rb"
  owner "root"
  group "root"
  mode "644"
end

remote_file "/etc/init.d/unicorn" do
  source "unicorn-init.sh"
  owner "root"
  group "root"
  mode "755"
end

link "/usr/bin/unicorn" do
  to "/var/lib/gems/1.8/bin/unicorn"
  only_if "test -f /var/lib/gems/1.8/bin/unicorn"
end

link "/usr/bin/unicorn_rails" do
  to "/var/lib/gems/1.8/bin/unicorn_rails"
  only_if "test -f /var/lib/gems/1.8/bin/unicorn_rails"
end

link "/usr/bin/unicorn" do
  to "/usr/local/bin/unicorn"
  only_if "test -f /usr/local/bin/unicorn"
end

link "/usr/bin/unicorn_rails" do
  to "/usr/local/bin/unicorn_rails"
  only_if "test -f /usr/local/bin/unicorn_rails"
end

service "unicorn" do
  supports :start => true, :restart => true, :stop => true
  action :enable
end