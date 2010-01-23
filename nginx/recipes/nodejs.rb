include_recipe "nginx"

template "/etc/nginx/sites-available/app" do
  source "nodejs-app.erb"
  owner "root"
  group "root"
  mode "644"
  notifies :restart, resources(:service => "nginx")
end