require_relative '../test_helper'

class WholesalersControllerTest < ActionController::TestCase
  
  test "should get index" do
    get :index
    assert_response :success
  end
  
end
