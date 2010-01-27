package "libncurses5-dev" do
  action :upgrade
end

path = "/usr/src/mysql-#{node[:mysql][:version]}"

user "mysql" do
  comment "MySQL user"
end

group "mysql" do
  members "mysql"
end

remote_file "/usr/src/mysql.tgz" do
  source node[:mysql][:source]
  checksum "a32bead5"
end

execute "untar mysql" do
  command "tar xzf mysql.tgz"
  cwd "/usr/src"
  creates "#{path}/README"
end

execute "configure mysql" do
  command "./configure --prefix=/usr \
    --exec-prefix=/usr \
    --libexecdir=/usr/sbin \
    --datadir=/usr/share \
    --localstatedir=/var/lib/mysql \
    --includedir=/usr/include \
    --infodir=/usr/share/info \
    --mandir=/usr/share/man \
    --enable-local-infile \
    --with-charset=utf8 \
    --with-collation=utf8_unicode_ci \
    --with-plugins=innobase,myisam \
    --with-mysqld-user=mysql"
  creates "#{path}/config.log"
  cwd "#{path}"
end

remote_file "#{path}/storage/innobase/handler/xtradb.patch" do
  source "xtradb.patch"
  mode "644"
end

execute "patch mysql" do
  command "patch < xtradb.patch && touch patched"
  creates "#{path}/storage/innobase/handler/patched"
  cwd "#{path}/storage/innobase/handler"
end

execute "make mysql" do
  command "make"
  cwd "#{path}"
end

execute "install mysql" do
  command "make install"
  cwd "#{path}"
end