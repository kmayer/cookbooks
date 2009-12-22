include_recipe "haproxy"
include_recipe "nginx"

conf = "thin-app.erb"

if node[:nginx][:ssl] == "true"
  conf = "thin-app-ssl.erb"
end

template "/etc/nginx/sites-available/app" do
  source conf
  owner "root"
  group "root"
  mode "644"
  notifies :restart, resources(:service => "nginx")
end