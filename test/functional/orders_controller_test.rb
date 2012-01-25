require 'test_helper'

class OrdersControllerTest < ActionController::TestCase

  PRICE = BigDecimal.new("19.99")
  WHOLESALE = BigDecimal.new("18.00")
  
  should "get show" do
    @wholesaler = Factory.create(:wholesaler)
    @user  = @wholesaler.user
    @order = Factory.create(:order, :wholesale => true, :user => @user)
    @order.add_variant(products(:wholesale).master)
    @order.reload
        
    assert_equal WHOLESALE, @order.item_total
    assert @order.is_wholesale? 
    assert @user.wholesaler?
    
    sign_in(@user)
    
    assert @user.orders.include?(@order), "Wholesale order belongs to our signed in user"
    
    get :show, { :id => @order.number }
    
    assert_response :success
    assert_tag :tag => "h4", :content => "Wholesale Customer ID: ##{@user.id}", :attributes => { :class => "wholesale-customer-id" }
    assert_not_nil assigns(:order), "Order is assigned to @order"
  end
  
end
