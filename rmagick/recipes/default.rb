include_recipe "imagemagick"
include_recipe "ghostscript"

gem_package "rmagick" do
  path = node[:rvm][:gem_binary]
  gem_binary path if path
  action :upgrade
end