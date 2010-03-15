if recipe?("rvm")
  set_unless[:unicorn][:gem_home] = `/home/rvm/.rvm/bin/default_gem environment gemdir`.strip
else
  set_unless[:unicorn][:gem_home] = `gem environment gemdir`.strip
end

set_unless[:unicorn][:cow_friendly] = "true"