package "libpq-dev" do
  action :upgrade
end

gem_package "pg" do
  action :upgrade
end