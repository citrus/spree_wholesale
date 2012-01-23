# Define a bare test case to use with Capybara

class ActiveSupport::IntegrationCase < ActiveSupport::TestCase

  include Capybara::DSL
  include Rails.application.routes.url_helpers
  include Warden::Test::Helpers    

  self.use_transactional_fixtures = false
  self.fixture_path = File.expand_path('../../fixtures', __FILE__)

  teardown do
    DatabaseCleaner.clean       # Truncate the database
    Capybara.reset_sessions!    # Forget the (simulated) browser state
    Capybara.use_default_driver # Revert Capybara.current_driver to Capybara.default_driver
  end
    
  def assert_seen(text, opts={})
    if opts[:within]
      within(opts[:within]) do
        assert page.has_content?(text)
      end
    else
      assert page.has_content?(text)
    end
  end
  
  def assert_flash(key, text)
    within(".errorExplanation") do
      assert_seen(text)
    end
  end

end
