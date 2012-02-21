CheckoutController.instance_eval do 
  before_filter :get_addresses
  before_filter :remove_payments_attributes
end

CheckoutController.class_eval do 

  def get_addresses
    return unless current_user && current_user.wholesaler? && !current_user.wholesaler.nil?
    @order.bill_address = current_user.wholesaler.bill_address
    @order.ship_address = current_user.wholesaler.ship_address
  end

  def remove_payments_attributes
    if @order.is_wholesale? && @order.payment? && @order.wholesaler.terms != "Credit Card" && params[:order_pay_at] == "later"
      params.delete :payment_source if params[:payment_source].present?
      params[:order].delete :payments_attributes if params[:order][:payments_attributes].present?
    end
  end
end
