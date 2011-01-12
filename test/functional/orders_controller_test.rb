class OrdersControllerTest < ActionController::TestCase
  
  test "should get show" do
    user = wholesale_user
    sign_in(user)
    
    order = orders(:wholesale)
    order.user_id = user.id
    order.save
    
    assert user.orders.include?(order)
    
    get :show, { :id => order.number }
    
    assert_response :success
    assert_tag :tag => "h4", :content => "Wholesale Customer ID: ##{user.id}", :attributes => { :class => "wholesale-customer-id" }
    assert_not_nil assigns(:order)
  end
  
end
