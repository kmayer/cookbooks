include_recipe "postfix"

package "monit" do
  action :upgrade
end

service "monit" do
  supports :status => true, :restart => true, :reload => true
  action :enable
end

template "/etc/default/monit" do
  source "monit.erb"
  owner "root"
  group "root"
  mode "644"
end