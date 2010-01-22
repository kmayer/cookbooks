%w( scons subversion ).each do |p|
  package p do
    action :upgrade
  end
end

package "libc6-dev-i386" do
  action :upgrade
  only_if do node[:kernel][:machine] == "x86_64" end
end

execute "checkout v8" do
  command "svn checkout http://v8.googlecode.com/svn/trunk v8"
  creates "/usr/src/v8/ChangeLog"
  cwd "/usr/src"
end

# http://code.google.com/p/v8/issues/detail?id=413
remote_file "/usr/src/v8/no-strict-aliasing.patch" do
  source "no-strict-aliasing.patch"
  mode "644"
end

execute "patch v8" do
  command "patch < no-strict-aliasing.patch && touch patched"
  creates "/usr/src/v8/patched"
  cwd "/usr/src/v8"
end

execute "build v8" do
  command "scons"
  environment "GCC_VERSION" => "44"
  creates "/usr/src/v8/libv8.a"
  cwd "/usr/src/v8"
end