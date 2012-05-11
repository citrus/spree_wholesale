require 'test_helper'

class Spree::ProductTest < ActiveSupport::TestCase

  fixtures :products

  should "respond to wolesale price" do
    product = products(:wholesale)
    assert product.master.respond_to?(:wholesale_price), "Product is not wholesale ready. Try running `rake db:migrate` first."
  end

  should "be wholesaleble" do
    product = products(:wholesale)
    assert product.is_wholesaleable?
  end


end
