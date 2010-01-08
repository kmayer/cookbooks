include_recipe "imagemagick"

gem_package "rmagick" do
  action :upgrade
end