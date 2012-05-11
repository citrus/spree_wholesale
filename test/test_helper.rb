# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"

env = File.expand_path("../dummy/config/environment.rb",  __FILE__)
if File.exists?(env)
  require env
else
  raise LoadError, "Please create the dummy app before running tests. Try running `bundle exec dummier`"
end

require 'rails/test_help'
require 'shoulda'
require 'factory_girl'
require 'capybara/rails'

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

include HelperMethods

ActionMailer::Base.delivery_method    = :test
ActionMailer::Base.perform_deliveries = false
ActionMailer::Base.default_url_options[:host] = "example.com"

Rails.backtrace_cleaner.remove_silencers!

# Configure capybara for integration testing
Capybara.default_driver    = :selenium
Capybara.default_selector  = :css

# Run any available migration
ActiveRecord::Migrator.migrate File.expand_path("../dummy/db/migrate/", __FILE__)

module FixturesHelper

  extend ActiveSupport::Concern

  included do
    self.fixture_path = File.expand_path('../fixtures/spree', __FILE__)
    set_fixture_class :addresses   => Spree::Address
    set_fixture_class :countries   => Spree::Country
    set_fixture_class :orders      => Spree::Order
    set_fixture_class :products    => Spree::Product
    set_fixture_class :roles       => Spree::Role
    set_fixture_class :states      => Spree::State
    set_fixture_class :variants    => Spree::Variant
    set_fixture_class :wholesalers => Spree::Wholesaler
    fixtures :all
  end

end

class ActionController::TestCase
  include Devise::TestHelpers
  include FixturesHelper
end

class ActiveSupport::TestCase
  include FixturesHelper
end

# Default to US
Spree::Config.set(:default_country_id => 214)
FactoryGirl.reload
