require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

desc 'Start an IRB session in the context of the current bundle'
task :irb do
	sh 'bundle console'
end

desc 'Run a coveralls report (includes tests)'
task :report do
  sh 'coveralls report'
end
