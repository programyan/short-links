require 'rspec/core/rake_task'

require_relative 'system/boot.rb'

desc 'Start IRB with application environment loaded'
task :console do
	exec 'irb -r./system/boot'
end

desc 'Run the specs'
task :spec do
	RSpec::Core::RakeTask.new(:spec)
end
