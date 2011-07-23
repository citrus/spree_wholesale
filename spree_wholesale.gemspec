# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "spree_wholesale/version"

Gem::Specification.new do |s|
  s.name        = "spree_wholesale"
  s.version     = SpreeWholesale::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Spencer Steffen"]
  s.email       = ["spencer@citrusme.com"]
  s.homepage    = "https://github.com/citrus/spree_wholesale"
  s.summary     = %q{Wholesale accounts for Spree Commerce.}
  s.description = %q{Spree Wholesale adds a wholesale_price field to variants and allows users with a "wholesaler" role to access these prices.}
 
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  
  s.require_paths = ["lib"]
  
  s.add_dependency('spree_core', '>= 0.60.0')
  s.add_dependency('spree_auth', '>= 0.60.0')
  s.add_dependency('deface')
  
  s.add_development_dependency('spree_sample',       '>= 0.60.0')
  s.add_development_dependency('shoulda',            '>= 2.11.3')
  s.add_development_dependency('factory_girl',       '>= 2.0.0.beta2')
	s.add_development_dependency('capybara',           '>= 0.4.1')
	s.add_development_dependency('spork',              '>= 0.9.0.rc5')
  s.add_development_dependency('spork-testunit',     '>= 0.0.5')
	s.add_development_dependency('sqlite3',            '>= 1.3.3')
  s.add_development_dependency('faker',              '>= 0.9.5')
  s.add_development_dependency('dummier',            '>= 0.1.0')
  
	#s.add_development_dependency('selenium-webdriver', '>= 0.2.0')

end
