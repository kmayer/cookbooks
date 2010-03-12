set_unless[:rvm][:default] = "1.9.1"

if recipe?("rvm")
  set_unless[:rvm][:gem_binary] = "/home/rvm/.rvm/bin/default_gem"
end