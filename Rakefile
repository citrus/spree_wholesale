# encoding: UTF-8
require 'rubygems'
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rake'
require 'rake/testtask'
#require 'rake/rdoctask'

Bundler::GemHelper.install_tasks

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

task :default => :test



desc "builds dummy app for testing"
task :test_app do

  #require 'spree_core'
  #require 'spree_core/generators/spree/test_app_generator'
  require 'spree_wholesale/generators/test_app_generator'
  
    
  SpreeWholesale::Generators::TestAppGenerator.start
end

#NV['SPREE_GEM_PATH'] = __FILE__
#require File.expand_path("../../core/lib/tasks/common", __FILE__)




#Rake::RDocTask.new(:rdoc) do |rdoc|
#  rdoc.rdoc_dir = 'rdoc'
#  rdoc.title    = 'SpreeWholesale'
#  rdoc.options << '--line-numbers' << '--inline-source'
#  rdoc.rdoc_files.include('README.md')
#  rdoc.rdoc_files.include('lib/**/*.rb')
#end