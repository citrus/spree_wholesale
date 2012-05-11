require 'test_helper'

class Spree::OrderTest < ActiveSupport::TestCase

  PRICE = BigDecimal.new("19.99")
  WHOLESALE = BigDecimal.new("18.00")

  fixtures :orders, :products

  def setup
    @wholesaler = Factory.create(:wholesaler)
  end

  should "respond to wholesale" do
    order = Spree::Order.new
    assert order.respond_to?(:wholesale)
  end

  should "be wholesale" do
    order = Factory.create(:order, :user => @wholesaler.user, :wholesale => true)
    assert order.is_wholesale?
  end

  should "convert to wholesale" do
    order = Factory.create(:order, :user => Factory.create(:user))
    assert !order.is_wholesale?
    assert !order.to_wholesale!
    assert !order.is_wholesale?
    order.user.wholesaler = @wholesaler
    assert order.to_wholesale!
    assert order.is_wholesale?
  end

  should "get regular price" do
    order = Factory.create(:order)
    assert_equal 0, order.item_total
    order.add_variant(products(:wholesale).master)
    order.update!
    assert_equal PRICE, order.item_total
  end

  should "get wholesale price" do
    order = Factory.create(:order, :user => @wholesaler.user, :wholesale => true)
    assert_equal 0, order.item_total
    order.add_variant(products(:wholesale).master)
    order.update!
    assert_equal WHOLESALE, order.item_total
  end

end
