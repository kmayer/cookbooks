gem_package "unicorn" do
  action :upgrade
end

service "unicorn" do
  supports :start => true, :stop => true, :restart => true, :reload => true
  action :enable
end

directory "/etc/unicorn" do
  owner "root"
  group "root"
  mode "755"
  action :create
end

template "/etc/init.d/unicorn" do
  source "/etc/init.d/unicorn-init.sh.erb"
  owner "root"
  group "root"
  mode "755"
end

template "/etc/unicorn/app.rb" do
  source "unicorn.rb.erb"
  owner "root"
  group "root"
  mode "644"
  notifies :restart, resources(:service => "unicorn")
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