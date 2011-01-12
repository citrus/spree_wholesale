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


desc "Test Spree Wholesale Extension"
task :test_extension do
  require File.expand_path('../test/test_helper', __FILE__)
    
  Dir["test/**/*.rb"].reject{|file| file.match(/test_helper/) != nil }.each do |file|
    puts "Loading #{file}"
    load file
  end
  
end


desc "Default Task"
task :default => [ :test_extension ]
