%w( libxml2-dev libxslt1-dev ).each do |p|
  package p do
    action :upgrade
  end
end

gem_package "nokogiri" do
  path = node[:rvm][:gem_binary]
  gem_binary path if path
  action :upgrade
end
