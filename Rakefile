require 'bundler/gem_tasks'

begin
  require 'aptible/tasks'
  Aptible::Tasks.load_tasks
rescue LoadError
  task :default
end
