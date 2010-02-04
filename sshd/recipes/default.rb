service "sshd" do
  service_name "ssh"
  supports :restart => true, :reload => true, :status => true
end

execute "Disable sshd password authentication" do
  command "sed --in-place \"s/#PasswordAuthentication yes/PasswordAuthentication no/g\" /etc/ssh/sshd_config"
  only_if "grep \"#PasswordAuthentication yes\" /etc/ssh/sshd_config"
  notifies :reload, resources(:service => "sshd")
  action :run
end

execute "Disable root login via ssh" do
  command "sed --in-place \"s/PermitRootLogin yes/PermitRootLogin no/g\" /etc/ssh/sshd_config"
  only_if "grep \"PermitRootLogin yes\" /etc/ssh/sshd_config"
  notifies :reload, resources(:service => "sshd")
  action :run
end