include_recipe "git"
include_recipe "v8"

execute "clone node" do
  command "git clone git://github.com/ry/node.git"
  creates "/usr/src/node/README"
  cwd "/usr/src"
end

directory "/usr/src/node/deps/v8" do
  recursive true
  not_if "test -h /usr/src/node/deps/v8"
  action :delete
end

link "/usr/src/node/deps/v8" do
  to "/usr/src/v8"
end

execute "clone node" do
  command "git clone git://github.com/ry/node.git"
  creates "/usr/src/node/README"
  cwd "/usr/src"
end

execute "configure node" do
  command "./configure"
  creates "/usr/src/node/build/config.log"
  cwd "/usr/src/node"
end

execute "make node" do
  command "make"
  environment "GCC_VERSION" => "44"
  cwd "/usr/src/node"
end

execute "install node" do
  command "make install"
  cwd "/usr/src/node"
end