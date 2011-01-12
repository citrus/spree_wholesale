class OrderTest < ActiveSupport::TestCase

  test "order responds to wholesale" do
    order = Order.new
    assert order.respond_to?(:wholesale), "Order is not wholesale ready. Try running `rake db:migrate` first."
  end
  
  test "order is_wholesale?" do
    order = orders(:wholesale)
    assert order.is_wholesale?
  end
  
  test "order gets wholesale price" do
    order = orders(:incomplete)
    order.line_items = []
    order.wholesale = true
    order.save
    order.add_variant(products(:wholesale).master)
    order.update!
    assert_equal WHOLESALE, order.item_total
  end
  
  test "order gets regular price" do
    order = orders(:incomplete)
    order.line_items = []
    order.save
    order.add_variant(products(:wholesale).master)
    order.update!
    assert_equal PRICE, order.item_total
  end
  
end
