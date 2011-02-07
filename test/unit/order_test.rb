require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  fixtures :orders, :products
  
  should "respond to wholesale" do
    order = Order.new
    assert order.respond_to?(:wholesale), "Order is not wholesale ready. Try running `rake db:migrate` first."
  end
  
  should "be wholesale" do
    order = orders(:wholesale)
    assert order.is_wholesale?
  end
  
  should "convert to wholesale" do
    order = orders(:incomplete)
    assert !order.is_wholesale?
    order.to_wholesale!    
    assert order.is_wholesale?
  end
  
  should "get wholesale price" do
    order = orders(:incomplete)
    order.line_items = []
    order.wholesale = true
    order.save
    order.add_variant(products(:wholesale).master)
    order.update!
    assert_equal WHOLESALE, order.item_total
  end
  
  should "get regular price" do
    order = orders(:incomplete)
    order.line_items = []
    order.save
    order.add_variant(products(:wholesale).master)
    order.update!
    assert_equal PRICE, order.item_total
  end
  
end
