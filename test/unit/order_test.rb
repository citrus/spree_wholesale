class OrderTest < ActiveSupport::TestCase

  test "order responds to wholesale" do
    order = get_order
    assert order.respond_to?(:wholesale), "Order is not wholesale ready. Try running `rake db:migrate` first."
  end
  
  test "order is_wholesale?" do
    order = get_order
    order.wholesale = true
    assert order.is_wholesale?
  end
  
  test "order gets wholesale price" do
    order = Order.new
    order.wholesale = true
    order.save
    order.add_variant(get_wholesale_product.master)
    order.update!
    assert_equal WHOLESALE, order.item_total
  end
  
  test "order gets regular price" do
    order = Order.new
    order.save
    order.add_variant(get_wholesale_product.master)
    order.update!
    assert_equal PRICE, order.item_total
  end
  
end
