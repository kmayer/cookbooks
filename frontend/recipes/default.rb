include_recipe "haproxy"
include_recipe "nginx"
include_recipe "www-data"

file "/etc/nginx/sites-enabled/default" do
  action :delete
end

link "/etc/nginx/sites-enabled/app" do
  to "/etc/nginx/sites-available/app"
end

template "/etc/nginx/sites-available/app" do
  source "app.erb"
  notifies :restart, resources(:service => "nginx")
end

if node[:frontend][:ssl] == "true"
  link "/etc/nginx/sites-enabled/app-ssl" do
    to "/etc/nginx/sites-available/app-ssl"
  end
  
  template "/etc/nginx/sites-available/app-ssl" do
    source "app-ssl.erb"
    notifies :restart, resources(:service => "nginx")
  end
end