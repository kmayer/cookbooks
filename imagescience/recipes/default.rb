package "libfreeimage-dev" do
  action :upgrade
end

%w( RubyInline image_science ).each do |g|
  gem_package g do
    path = node[:rvm][:gem_binary]
    gem_binary path if path
    action :upgrade
  end
end