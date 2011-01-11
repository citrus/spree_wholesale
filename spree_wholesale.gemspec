Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_wholesale'
  s.version     = '0.0.1'
  s.summary     = 'Add wholesale functionality to spree'
  #s.description = 'Add (optional) gem description here'
  
  s.required_ruby_version = '>= 1.8.7'

  s.author            = 'Spencer Steffen'
  s.email             = 'spencer@citrusme.com'
  s.homepage          = 'http://citrusme.com'

  s.files        = Dir['CHANGELOG', 'README.md', 'LICENSE', 'lib/**/*', 'app/**/*']
  s.require_path = 'lib'
  s.requirements << 'none'

  s.has_rdoc = true

  s.add_dependency('spree_core', '>= 0.40.0')
end