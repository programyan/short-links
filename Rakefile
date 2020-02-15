# frozen_string_literal: true

require 'rspec/core/rake_task'
require 'api'

require_relative 'system/boot.rb'

desc 'Start IRB with application environment loaded'
task :console do
  exec 'irb -r./system/boot'
end

desc 'Run the specs'
task :spec do
  RSpec::Core::RakeTask.new(:spec)
end

desc 'Print routes'
task :routes do
  Api.routes.each do |route|
    method = route.request_method.ljust(10)
    path = route.origin
    puts "     #{method} #{path}"
  end
end
