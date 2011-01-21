Gem::Specification.new do |s|
  s.platform     = Gem::Platform::RUBY
  s.name         = 'spree_wholesale'
  s.required_ruby_version = '>= 1.8.7'
  s.version      = '0.40.2.beta'
          
  s.summary      = 'Add wholesale functionality to spree'
  s.description  = 'Spree Wholesale adds a wholesale_price field to variants and allows users with a "wholesaler" role to access these prices.'
  
  s.author       = 'Spencer Steffen'
  s.email        = 'spencer@citrusme.com'
  s.homepage     = 'http://github.com/citrus/spree_wholesale'

  s.files        = Dir['CHANGELOG', 'README.md', 'LICENSE', 'config/**/*', 'lib/**/*', 'app/**/*', 'db/**/*', 'public/**/*', 'Rakefile']
  s.require_path = 'lib'
  s.requirements << 'none'

  s.has_rdoc = false

  s.add_dependency('spree_core', '>= 0.40.2')
  s.add_dependency('spree_auth', '>= 0.40.2')
end