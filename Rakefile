require File.expand_path('../../config/application', __FILE__)

require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/packagetask'
require 'rake/gempackagetask'

spec = eval(File.read('spree_wholesale.gemspec'))

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
end


desc "Release to gemcutter"
task :release => :package do
  require 'rake/gemcutter'
  Rake::Gemcutter::Tasks.new(spec).define
  Rake::Task['gem:push'].invoke
end





desc "Test Spree Wholesale Extension"
task :test_extension do
  require File.expand_path('../test/test_helper', __FILE__)
  
  
  dir = File.expand_path('../test/unit', __FILE__)
  Dir.entries(dir).select{|file| file.match('_test.rb') }.each do |file|
    load File.join(dir, file)
  end
  
  
  dir = File.expand_path('../test/functional', __FILE__)
  Dir.entries(dir).select{|file| file.match('_test.rb') }.each do |file|
    load File.join(dir, file)
  end
  
  
end


desc "Default Task"
task :default => [ :test_extension ]
