include_recipe "monit"

template "/etc/monit/monitrc" do
  source "monitrc-mongrel.erb"
  owner "root"
  group "root"
  mode "600"
  only_if "test -f /etc/mongrel/app.yml"
  end_port = node[:monit][:start_port].to_i + node[:monit][:servers].to_i - 1
  variables(
    :start_port => node[:monit][:start_port].to_i,
    :end_port => end_port,
    :email => node[:monit][:email])
  notifies :reload, resources(:service => "monit")
end