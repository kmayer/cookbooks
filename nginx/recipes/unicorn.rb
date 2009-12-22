include_recipe "nginx"

file "/etc/nginx/sites-enabled/default" do
  action :delete
end

link "/etc/nginx/sites-enabled/app" do
  to "/etc/nginx/sites-available/app"
end

template "/etc/nginx/sites-available/app" do
  source "unicorn-app.erb"
  notifies :restart, resources(:service => "nginx")
end