CheckoutController.instance_eval do 
  
  before_filter :get_addresses
  
end

CheckoutController.class_eval do 

  def get_addresses
    return unless current_user.has_role?("wholesaler") && !current_user.wholesaler.nil?
    @order.bill_address = current_user.wholesaler.bill_address
    @order.ship_address = current_user.wholesaler.ship_address
  end

end