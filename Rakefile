require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = '--format documentation'
end

task :default => :spec
task :test => :spec  # Add this line to make 'rake test' work