require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/packagetask'
require 'rake/gempackagetask'

root = ENV["RAILS_ROOT"] || File.expand_path('../../', __FILE__)
env = File.join(root, 'config', 'environment.rb')

puts "(Rails Root: #{root})"


spec = eval(File.read('spree_wholesale.gemspec'))

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
end


desc "Test Spree Wholesale Extension"
task :test_extension do

  require env
  require File.expand_path('../test/test_helper', __FILE__)
    
  Dir["test/**/*.rb"].reject{|file| file.match(/test_helper/) != nil }.each do |file|
    puts "Loading #{file}"
    load file
  end
  
end


if File.exists?(env)
  desc "Default Task"
  task :default => [ :test_extension ]
else
  desc "Default Task"
  task :default => []
  puts "environment.rb not found! Try modifying the path to your rails application."
end
