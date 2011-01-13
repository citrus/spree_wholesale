#require File.expand_path('../../../config/environment', __FILE__)



ENV["RAILS_ENV"] = "test"
require 'rails/test_help'

class ActiveSupport::TestCase

  self.fixture_path = File.expand_path('../fixtures', __FILE__)

  PRICE = BigDecimal.new("19.99")
  WHOLESALE = BigDecimal.new("18.00")

  EMAIL = "spree@example.com"
  PASSWORD = "spree123"

  fixtures :all
  
  def wholesale_user
    return @user if @user
    @user = User.find_by_email("spree@example.com") rescue nil
    unless @user
      @user = User.new(
        :password => PASSWORD,
        :password_confirmation => PASSWORD,
        :email => EMAIL,
        :login => EMAIL
      )
      @user.roles << roles(:user) unless @user.has_role?("user")
      @user.roles << roles(:wholesaler) unless @user.has_role?("wholesaler")
      @user.save
    end
    @user
  end
  
end

class ActionController::TestCase
  include Devise::TestHelpers
end


class ActionController::IntegrationTest
  self.fixture_path = File.expand_path('../fixtures', __FILE__)
end