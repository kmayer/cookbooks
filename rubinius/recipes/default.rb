include_recipe "git"
include_recipe "rake"

%w( libreadline6-dev libssl-dev zlib1g-dev llvm-dev ).each do |p|
  package p do
    action :upgrade
  end
end

execute "clone rubinius" do
  command "git clone git://github.com/evanphx/rubinius.git"
  cwd "/usr/src"
  creates "/usr/src/rubinius/README"
end

execute "configure rubinius" do
  command "./configure --prefix /usr/local"
  cwd "/usr/src/rubinius"
  creates "/usr/src/rubinius/config.rb"
end

execute "build rubinius" do
  command "rake build"
  cwd "/usr/src/rubinius"
  creates "/usr/src/rubinius/vm/vm"
end

execute "install rubinius" do
  command "rake install"
  cwd "/usr/src/rubinius"
  creates "/usr/local/rubinius/bin/rbx"
end