package "ruby1.9.1-full" do
  action :upgrade
end

link "/usr/bin/ruby" do
  to "/usr/bin/ruby1.9.1"
end

link "/usr/bin/irb" do
  to "/usr/bin/irb1.9.1"
end

link "/usr/bin/rdoc" do
  to "/usr/bin/rdoc1.9.1"
end

link "/usr/bin/ri" do
  to "/usr/bin/ri1.9.1"
end

include_recipe "rubygems"