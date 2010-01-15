unless File.exist? '/usr/local/nginx/sbin/nginx'
  include_recipe "nginx::system"
  include_recipe "nginx::compiled"
else
  service "nginx" do
    supports :status => false, :restart => false, :reload => false
    action [ :enable, :start ]
  end
  
  class Chef::Recipe
    include NginxVersion
  end
  nginx_version()
  
  node[:nginx][:path] = "/usr/local/nginx/sbin/"
  
  if node[:nginx][:version] == "0.6.39"
    include_recipe "nginx::legacy"
  else
    include_recipe "nginx::compiled"
  end
end