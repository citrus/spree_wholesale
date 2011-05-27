require_relative '../test_helper'

class OrdersControllerTest < ActionController::TestCase
  
  should "get show" do
    @order = Factory.create(:wholesale_order)
    @user = @order.user
    @wholesaler = @user.wholesaler
    
    assert @user.wholesaler?
    
    sign_in(@user)
    
    assert @user.orders.include?(@order), "Wholesale order belongs to our signed in user"
    
    get :show, { :id => @order.number }
    
    assert_response :success
    assert_tag :tag => "h4", :content => "Wholesale Customer ID: ##{@user.id}", :attributes => { :class => "wholesale-customer-id" }
    assert_not_nil assigns(:order), "Order is assigned to @order"
  end
  
end
