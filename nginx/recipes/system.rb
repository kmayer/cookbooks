package "nginx" do
  options "--option Dpkg::Options::=\"--force-confnew\""
  action :upgrade
end

service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action :enable
end

directory "/var/www/nginx-default" do
  recursive true
  action :delete
end

file "/etc/nginx/sites-enabled/default" do
  action :delete
end

link "/etc/nginx/sites-enabled/app" do
  to "/etc/nginx/sites-available/app"
end

link "/etc/nginx/ssl.cert" do
  to "/etc/nginx/cert.pem"
  only_if "test -f /etc/nginx/cert.pem"
end

link "/etc/nginx/ssl.key" do
  to "/etc/nginx/cert.key"
  only_if "test -f /etc/nginx/cert.key"
end

remote_file "/etc/nginx/ssl.cert" do
  source "bogus.cert"
  owner "root"
  group "root"
  mode "644"
  not_if "test -f /etc/nginx/ssl.cert"
end

remote_file "/etc/nginx/ssl.key" do
  source "bogus.key"
  owner "root"
  group "root"
  mode "600"
  not_if "test -f /etc/nginx/ssl.key"
end

template "/etc/nginx/nginx.conf" do
  source "nginx.conf.erb"
  owner "root"
  group "root"
  mode "644"
  variables(
    :log_format_name => node[:nginx][:log_format_name],
    :log_format => node[:nginx][:log_format])
  notifies :reload, resources(:service => "nginx")
end