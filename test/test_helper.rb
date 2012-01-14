# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"
require 'spork'

Spork.prefork do

  env = File.expand_path("../dummy/config/environment.rb",  __FILE__)
  if File.exists?(env)
    require env
  else
    raise LoadError, "Please create the dummy app before running tests. Try running `bundle exec dummier`"
  end
  
  require 'rails/test_help'
  require 'shoulda'
  require 'shoulda/rails'
  require 'factory_girl'
  require 'capybara/rails'

  ActionMailer::Base.delivery_method    = :test
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.default_url_options[:host] = "example.com"

  Rails.backtrace_cleaner.remove_silencers!

  # Configure capybara for integration testing
  Capybara.default_driver    = :selenium
  Capybara.default_selector  = :css
  
  # Run any available migration
  ActiveRecord::Migrator.migrate File.expand_path("../dummy/db/migrate/", __FILE__)
  
  class ActionController::TestCase
    include Devise::TestHelpers
  end
    
  class ActiveSupport::TestCase
    self.fixture_path = File.expand_path('../fixtures', __FILE__)
    fixtures :all
  end
  
  class ActionController::IntegrationTest
    self.fixture_path = File.expand_path('../fixtures', __FILE__)
  end

end

Spork.each_run do

  # Default to US
  Spree::Config.set(:default_country_id => 214)
  
  # Load support files
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
  
  include HelperMethods
  
end
