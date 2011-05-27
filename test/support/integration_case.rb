# Define a bare test case to use with Capybara

class ActiveSupport::IntegrationCase < ActiveSupport::TestCase

  include Capybara
  include Rails.application.routes.url_helpers
  include Warden::Test::Helpers    

  self.use_transactional_fixtures = false
  self.fixture_path = File.expand_path('../../fixtures', __FILE__)

  def assert_seen(text, opts={})
    if opts[:within]
      within(opts[:within]) do
        assert has_content?(text)
      end
    else
      assert has_content?(text)
    end
  end
  
  def assert_flash(key, text)
    within(".flash.#{key}") do
      assert_seen(text)
    end
  end

end
