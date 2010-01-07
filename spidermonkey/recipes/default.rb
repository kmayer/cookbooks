package "libnspr4-dev" do
  action :upgrade
end

remote_file "/tmp/js-1.7.0.tar.gz" do
  source "http://ftp.mozilla.org/pub/mozilla.org/js/js-1.7.0.tar.gz"
  checksum "44363f0f"
end

execute "untar spidermonkey" do
  command "tar xzf js-1.7.0.tar.gz"
  cwd "/tmp"
  creates "/tmp/js/README"  
  action :run
end

execute "build spidermonkey" do
  command "make -f Makefile.ref"
  cwd "/tmp/js/src"
  environment "CFLAGS" => "-DJS_C_STRINGS_ARE_UTF8"
  action :run
end

execute "install spidermonkey" do
  command "make -f Makefile.ref export"
  cwd "/tmp/js/src"
  environment "JS_DIST" => "/usr"
  action :run
end