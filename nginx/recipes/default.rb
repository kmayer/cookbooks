execute "disable legacy nginx" do
  command "/etc/init.d/nginx stop /dev/null 2>&1 && mv /usr/local/nginx /usr/local/nginx-disabled"
  ignore_failure true
  only_if "test -f /usr/local/nginx/sbin/nginx"
end

include_recipe "nginx::system"
include_recipe "nginx::compiled"