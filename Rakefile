require "bundler/gem_tasks"

namespace :spec do
  desc "Runs unit tests"
  task :unit do
    system("bundle exec rspec")
  end

  desc "Run all tests"
  task :all do
    Rake.application['spec:unit'].invoke
    raise "Unit testing failed!" unless $?.exitstatus == 0
  end
end

task default: 'spec:all'
