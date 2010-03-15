include_recipe "rmagick"

%w( prawn prawn-fast-png ).each do |g|
  gem_package g do
    path = node[:rvm][:gem_binary]
    gem_binary path if path
    action :upgrade
  end
end