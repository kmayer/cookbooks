include_recipe "postfix"

package "monit" do
  action :upgrade
end

template "/etc/default/monit" do
  source "monit.erb"
  owner "root"
  group "root"
  mode "644"
end

template "/etc/monit/monitrc" do
  source "monitrc.erb"
  owner "root"
  group "root"
  mode "600"
end

service "monit" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end