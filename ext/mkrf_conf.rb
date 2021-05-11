require 'rubygems'
require 'rubygems/command'
require 'rubygems/dependency_installer'

begin
  Gem::Command.build_args = ARGV
rescue NoMethodError
end

inst = Gem::DependencyInstaller.new
begin
  inst.install 'ruby-keychain' if RbConfig::CONFIG['host_os'] =~ /darwin/
rescue StandardError => e
  puts e.message
  puts e.backtrace
  exit 1
end
