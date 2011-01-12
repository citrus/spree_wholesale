class OrdersControllerTest < ActionController::TestCase

  include Devise::TestHelpers
  
  def get_wholesale_user
    @user = wholesale_user
    sign_in(@user)
  end 
  
  test "should get show" do
    get_wholesale_user
    @order = get_order(['user_id = ? AND completed_at IS NOT NULL', @user.id])
    get :show, { :id => @order.number }
    assert_response :success
    assert_tag :tag => "h4", :content => "Wholesale Customer ID: ##{@user.id}", :attributes => { :class => "wholesale-customer-id" }
    assert_not_nil assigns(:order)
  end
  
end
  