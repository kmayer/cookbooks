%w( openjdk-6-jdk ant ).each do |p|
  package p do
    action :upgrade
  end
end

remote_file "/tmp/jruby-src-1.4.0.tar.gz" do
  source "http://jruby.kenai.com/downloads/1.4.0/jruby-src-1.4.0.tar.gz"
  checksum "b9fd84ed"
end

execute "untar jruby" do
  command "tar -C /opt -xzf jruby-src-1.4.0.tar.gz"
  creates "/opt/jruby-1.4.0/README"
  cwd "/tmp"
  action :run
end

execute "build jruby" do
  command "ant"
  cwd "/opt/jruby-1.4.0"
  creates "/opt/jruby-1.4.0/lib/jruby.jar"
  action :run
end

link "/opt/jruby" do
  to "/opt/jruby-1.4.0"
end

link "/usr/bin/jruby" do
  to "/opt/jruby/bin/jruby"
end

link "/usr/bin/jirb" do
  to "/opt/jruby/bin/jirb"
end

link "/usr/bin/jgem" do
  to "/opt/jruby/bin/jgem"
end

execute "jgem install jruby-openssl" do
  command "jgem install jruby-openssl"
  creates "/opt/jruby-1.4.0/lib/ruby/gems/1.8/gems/jruby-openssl-0.6/README.txt"
  action :run
end