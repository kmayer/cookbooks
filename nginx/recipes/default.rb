nginx_version = node[:nginx][:version]

%w(nginx libpcre3-dev libssl-dev).each do |p|
  package p do
    action :upgrade
  end
end

service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
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

remote_file "/etc/nginx/ssl.cert" do
  source "bogus.cert"
  owner "root"
  group "root"
  mode 0644
  not_if "test -f /etc/nginx/ssl.cert"
end

remote_file "/etc/nginx/ssl.key" do
  source "bogus.key"
  owner "root"
  group "root"
  mode 0600
  not_if "test -f /etc/nginx/ssl.key"
end

remote_file "/usr/src/nginx-#{nginx_version}.tar.gz" do
  source "http://sysoev.ru/nginx/nginx-#{nginx_version}.tar.gz"
  mode 0644
  checksum "5705d08a"
end

execute "untar nginx" do
  command "tar xzf nginx-#{nginx_version}.tar.gz"
  cwd "/usr/src"
  creates "/usr/src/nginx-#{nginx_version}/README"
  action :run
end

execute "configure nginx" do
  command <<-EOH
    ./configure \
     --prefix=/usr \
     --sbin-path=/usr/sbin/nginx \
     --user=www-data \
     --group=www-data \
     --conf-path=/etc/nginx/nginx.conf \
     --error-log-path=/var/log/nginx/error.log \
     --pid-path=/var/run/nginx.pid \
     --lock-path=/var/lock/nginx.lock \
     --http-log-path=/var/log/nginx/access.log \
     --http-client-body-temp-path=/var/lib/nginx/body \
     --http-proxy-temp-path=/var/lib/nginx/proxy \
     --http-fastcgi-temp-path=/var/lib/nginx/fastcgi \
     --with-http_stub_status_module \
     --with-http_ssl_module \
     --with-http_gzip_static_module
  EOH
  cwd "/usr/src/nginx-#{nginx_version}"
  creates "/usr/src/nginx-#{nginx_version}/objs/Makefile"
  action :run
end

execute "make nginx" do
  command "make"
  cwd "/usr/src/nginx-#{nginx_version}"
  creates "/usr/src/nginx-#{nginx_version}/objs/nginx"
  action :run
end

execute "install nginx" do
  command "/etc/init.d/nginx stop && make install"
  cwd "/usr/src/nginx-#{nginx_version}"
  only_if do nginx_version > `/usr/sbin/nginx -v 2>&1`.strip.split('/')[1] end
  notifies :start, resources(:service => "nginx")
  action :run
end

template "/etc/nginx/nginx.conf" do
  source "nginx.conf.erb"
  owner "root"
  group "root"
  mode "644"
  notifies :reload, resources(:service => "nginx")
end