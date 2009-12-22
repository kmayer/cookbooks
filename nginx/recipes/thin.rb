include_recipe "haproxy"
include_recipe "nginx"

file "/etc/nginx/sites-enabled/default" do
  action :delete
end

link "/etc/nginx/sites-enabled/app" do
  to "/etc/nginx/sites-available/app"
end

template "/etc/nginx/sites-available/app" do
  source "thin-app.erb"
  notifies :restart, resources(:service => "nginx")
end

if node[:nginx][:ssl] == "true"
  link "/etc/nginx/sites-enabled/app-ssl" do
    to "/etc/nginx/sites-available/app-ssl"
  end
  
  template "/etc/nginx/sites-available/app-ssl" do
    source "thin-app-ssl.erb"
    notifies :restart, resources(:service => "nginx")
  end
end