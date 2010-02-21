package "libfreeimage-dev" do
  action :upgrade
end

%w( RubyInline image_science ).each do |g|
  gem_package g do
    action :upgrade
  end
end