include_recipe "imagemagick"
include_recipe "ghostscript"

gem_package "rmagick" do
  action :upgrade
end