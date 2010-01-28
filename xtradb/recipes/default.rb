template "/etc/apt/sources.list.d/percona.list" do
  source "percona.list.erb"
end

remote_file "/etc/chef/percona.gpg.key" do
  source "percona.gpg.key"
end

# this does nothing useful presently (wrong key?)
execute "add percona repository key" do
  command "apt-key add percona.gpg.key"
  cwd "/etc/chef"
  not_if "apt-key list | grep CD2EFD2A"
end

execute "update repository" do
  command "apt-get update"
  not_if "test -f /var/lib/apt/lists/repo.percona.com_apt_dists_jaunty_main_source_Sources"
end

package "mysql-server" do
  options "--force-yes"
  action :upgrade
end