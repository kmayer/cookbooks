worker_processes 4
working_directory '/var/www/current'
listen '/tmp/.unicorn-socket', :backlog => 64
timeout 30
pid '/var/run/unicorn.pid'

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end