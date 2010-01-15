legacy = "nginx-0.6.39"

remote_file "/usr/src/#{legacy}.tar.gz" do
  source "http://nginx.org/download/#{legacy}.tar.gz"
  mode "644"
  checksum "daf14292"
end

execute "untar nginx" do
  command "tar xzf #{legacy}.tar.gz"
  cwd "/usr/src"
  creates "/usr/src/#{legacy}/README"
  action :run
end

remote_file "/usr/src/#{legacy}/patch.cve-2009-3555.txt" do
  source "patch.cve-2009-3555.txt"
  mode "644"
end

execute "patch nginx" do
  command "patch --strip=0 --silent --input=patch.cve-2009-3555.txt"
  cwd "/usr/src/#{legacy}"
  ignore_failure true
  not_if "test -f /usr/src/#{legacy}/src/event/ngx_event_openssl.c.rej"
  action :run
end

execute "configure nginx" do
  command "./configure --with-http_ssl_module"
  cwd "/usr/src/#{legacy}"
  creates "/usr/src/#{legacy}/objs/ngx_auto_config.h"
  action :run
end

execute "make nginx" do
  command "make"
  cwd "/usr/src/#{legacy}"
  creates "/usr/src/#{legacy}/objs/nginx"
  action :run
end

execute "install nginx" do
  command "killall nginx && make install"
  cwd "/usr/src/#{legacy}"
  only_if do node[:nginx][:version] > `#{node[:nginx][:path]}/nginx -v 2>&1`.strip.split('/')[1] end
  notifies :start, resources(:service => "nginx")
  action :run
end