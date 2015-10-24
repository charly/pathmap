require "bundler/gem_tasks"


require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new :default do |t|
  t.libs << "test"
  t.test_files = FileList['test/models/*_test.rb']
  t.verbose = true
end