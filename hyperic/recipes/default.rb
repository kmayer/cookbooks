include_recipe "java"

user "hyperic" do
  comment "Hyperic User"
  home "/home/hyperic"
end

directory "/home/hyperic" do
  owner "hyperic"
  group "hyperic"
  mode "755"
  action :create
end