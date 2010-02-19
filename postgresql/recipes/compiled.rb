version = node[:postgresql][:compiled_version]

user "postgres" do
  action :create
end

remote_file "/usr/src/postgresql-#{version}.tar.bz2" do
  source "http://wwwmaster.postgresql.org/redir/198/h/source/v#{version}/postgresql-#{version}.tar.bz2"
  checksum node[:postgresql][:compiled_checksum]
end

execute "untar postgresql" do
  command "tar xjf postgresql-#{version}.tar.bz2"
  cwd "/usr/src"
  user "root"
  group "src"
  creates "/usr/src/postgresql-#{version}/README"
end

execute "configure postgresql" do
  command "./configure"
  cwd "/usr/src/postgresql-#{version}"
  user "root"
  creates "/usr/src/postgresql-#{version}/config.status"
end

execute "build postgresql" do
  command "make"
  cwd "/usr/src/postgresql-#{version}"
  user "root"
  creates "/usr/src/postgresql-#{version}/src/backend/postgres"
end

execute "install postgresql" do
  command "make install"
  cwd "/usr/src/postgresql-#{version}"
  user "root"
  creates "/usr/src/postgresql-#{version}/src/backend/postgres"
end

directory "/var/pgsql" do
  owner "postgres"
  group "postgres"
  mode "0755"
  action :create
end

execute "initialize database cluster" do
  command "/usr/local/pgsql/bin/initdb -D /var/pgsql/data"
  user "postgres"
  not_if "test -d /var/pgsql/data"
end