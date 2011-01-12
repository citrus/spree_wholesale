ENV["RAILS_ENV"] = "test"
require File.expand_path('../../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase

  PRICE = BigDecimal.new("49.99")
  WHOLESALE = BigDecimal.new("22.00")

  #fixtures :all
  
  def wholesale_user
    user = User.find_by_email("spencer@citrusme.com")
  end
      
  def get_order(conditions={})
    order = Order.where(conditions).first
    raise ActiveRecord::RecordNotFound unless order
    order
  end
    
  def get_product
    product = Product.includes(:master).first
    raise ActiveRecord::RecordNotFound unless product
    product
  end
  
  def get_wholesale_product
    product = get_product
    product.master.price = PRICE
    product.master.wholesale_price = WHOLESALE
    product.save
    product
  end
  
end
