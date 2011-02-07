# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"

env = File.expand_path("../dummy/config/environment.rb",  __FILE__)
unless File.exists?(env)
  require env
else
  raise LoadError, "Please create the dummy app before running tests."
end

require "rails/test_help"
require "shoulda"

ActionMailer::Base.delivery_method    = :test
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.default_url_options[:host] = "test.com"

Rails.backtrace_cleaner.remove_silencers!

# Configure capybara for integration testing
#require "capybara/rails"
#Capybara.default_driver   = :rack_test
#Capybara.default_selector = :css

# Run any available migration
ActiveRecord::Migrator.migrate File.expand_path("../dummy/db/migrate/", __FILE__)

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

include HelperMethods


if 40 <= Spree.version.split(".")[1].to_i
  class ActionController::TestCase
    include Devise::TestHelpers
  end
end


class ActiveSupport::TestCase
  self.fixture_path = File.expand_path('../fixtures', __FILE__)
  fixtures :all
end

class ActionController::IntegrationTest
  self.fixture_path = File.expand_path('../fixtures', __FILE__)
end