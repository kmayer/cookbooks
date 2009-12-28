include_recipe "monit"

link "/usr/bin/mongrel_rails" do
  to "/usr/local/bin/mongrel_rails"
  only_if "test -f /usr/local/bin/mongrel_rails"
end

template "/etc/monit/monitrc" do
  source "monitrc-mongrel.erb"
  owner "root"
  group "root"
  mode "600"
  only_if "test -f /etc/mongrel_cluster/app.yml"
  end_port = node[:monit][:start_port].to_i + node[:monit][:servers].to_i - 1
  variables (
    :start_port => node[:monit][:start_port].to_i,
    :end_port => end_port,
    :email => node[:monit][:email] )
  notifies :restart, resources(:service => "monit")
end