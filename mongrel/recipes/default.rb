%w( mongrel mongrel_cluster ).each do |g|
  gem_package g do
    action :upgrade
  end
end