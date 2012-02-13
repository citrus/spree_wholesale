class ActiveSupport::IntegrationCase < ActiveSupport::TestCase
  
  include Capybara::DSL
  include Rails.application.routes.url_helpers
  include Warden::Test::Helpers
  
  # Extreme hax! wtf is this for anyways.. and why is it erroring?
  def testmail_admin_mail_method_url(*args)
    "#wtf"  
  end
  alias :testmail_admin_mail_method_path :testmail_admin_mail_method_url
  
  
    
  self.use_transactional_fixtures = false

  # Checks for missing translations after each test
  teardown do
    unless source.blank?
      matches = source.match(/translation[\s-]+missing[^"<]*/) || []
      assert_equal 0, matches.length, "** #{matches[0]}"
    end
  end
  
  # An assertion for ensuring content has made it to the page.
  #    
  #    assert_seen "Site Title"
  #    assert_seen "Peanut Butter Jelly Time", :within => ".post-title h1"
  #      
  def assert_seen(text, opts={})
    if opts[:within]
      within(opts[:within]) do
        assert has_content?(text)
      end
    else
      assert has_content?(text)
    end
  end
  
  # Asserts the proper flash message
  #    
  #    assert_flash :notice, "Post was successfully saved!"
  #    assert_flash :error, "Oh No, bad things happened!"
  #
  def assert_flash(key, text)
    within(".flash.#{key}") do
      assert_seen(text)
    end
  end
  
  # Asserts the proper browser title
  #    
  #    assert_title "My Site - Is super cool"
  #
  def assert_title(title)
    assert_seen title, :within => "head title"
  end
  
  # Asserts meta tags have proper content
  #    
  #    assert_meta :description, "So let me tell you about this one time..."
  #    assert_meta :keywords, "seo, is, fun, jk."
  #
  def assert_meta(tag, text)
    tag = find(:xpath, "//head/meta[@name='#{tag.to_s}']")
    assert_equal text, tag.native.attribute("content")
  end
      
end


# # Define a bare test case to use with Capybara
# 
# class ActiveSupport::IntegrationCase < ActiveSupport::TestCase
# 
#   include Capybara::DSL
#   include Rails.application.routes.url_helpers
#   include Warden::Test::Helpers    
# 
#   self.use_transactional_fixtures = false
#   self.fixture_path = File.expand_path('../../fixtures', __FILE__)
# 
#   # Extreme hax! wtf is this for anyways.. and why is it erroring?
#   def testmail_admin_mail_method_url(*args)
#     "#wtf"  
#   end
#   alias :testmail_admin_mail_method_path :testmail_admin_mail_method_url
#   
#   teardown do
#     Capybara.reset_sessions!    # Forget the (simulated) browser state
#     Capybara.use_default_driver # Revert Capybara.current_driver to Capybara.default_driver
#   end
#     
#   def assert_seen(text, opts={})
#     if opts[:within]
#       within(opts[:within]) do
#         assert page.has_content?(text)
#       end
#     else
#       assert page.has_content?(text)
#     end
#   end
#   
#   def assert_flash(key, text)
#     within(".errorExplanation") do
#       assert_seen(text)
#     end
#   end
# 
# end
