%w(libpcre3-dev libssl-dev).each do |p|
  package p do
    action :upgrade
  end
end

remote_file "/usr/src/nginx-#{node[:nginx][:version]}.tar.gz" do
  source "http://sysoev.ru/nginx/nginx-#{node[:nginx][:version]}.tar.gz"
  mode "644"
  checksum "5705d08a"
end

execute "untar nginx" do
  command "tar xzf nginx-#{node[:nginx][:version]}.tar.gz"
  cwd "/usr/src"
  creates "/usr/src/nginx-#{node[:nginx][:version]}/README"
  action :run
end

execute "configure nginx" do
  unless File.exist? '/usr/local/nginx/sbin/nginx'
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
  else
    command "./configure --with-http_ssl_module"
  end
  cwd "/usr/src/nginx-#{node[:nginx][:version]}"
  creates "/usr/src/nginx-#{node[:nginx][:version]}/objs/Makefile"
  action :run
end

execute "make nginx" do
  command "make"
  cwd "/usr/src/nginx-#{node[:nginx][:version]}"
  creates "/usr/src/nginx-#{node[:nginx][:version]}/objs/nginx"
  action :run
end

execute "install nginx" do
  command "killall nginx && make install"
  cwd "/usr/src/nginx-#{node[:nginx][:version]}"
  only_if do node[:nginx][:version] > `#{node[:nginx][:path]}/nginx -v 2>&1`.strip.split('/')[1] end
  notifies :start, resources(:service => "nginx")
  action :run
end