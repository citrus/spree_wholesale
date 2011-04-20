CheckoutController.instance_eval do 
  
  before_filter :get_addresses
  
end

CheckoutController.class_eval do 

  def get_addresses
    return unless current_user && current_user.wholesaler? && !current_user.wholesaler.nil?
    @order.bill_address = current_user.wholesaler.bill_address
    @order.ship_address = current_user.wholesaler.ship_address
  end
  
  
  
  # Updates the order and advances to the next state (when possible.)
  def update
  
  
  
    #v = object_params[:source_attributes][:verification_value].to_s rescue ""

  
    puts "---------"
    puts @order.state
    
    if @order.is_wholesale? && @order.state == "payment" && @order.wholesaler.terms != "Credit Card" && params[:order_pay_at] == "later"
    
      puts "OH YA WHOLESALE BABY"
      puts @order.inspect
      
      puts @order.next
      puts "0000000000000000"
      puts @order.errors.inspect
      
      #cear
      puts @order.state     
      
      return redirect_to(checkout_state_path(@order.state))
    end
    
    
  
    if @order.update_attributes(object_params)
    
      puts "---------"
      puts @order.state
    
      if @order.next
        state_callback(:after)
      else
        flash[:error] = I18n.t(:payment_processing_failed)
        redirect_to checkout_state_path(@order.state) and return
      end
      
      puts @order.state
      

      if @order.state == "complete" || @order.completed?
        flash[:notice] = I18n.t(:order_processed_successfully)
        flash[:commerce_tracking] = "nothing special"
        redirect_to completion_route
      else
        redirect_to checkout_state_path(@order.state)
      end

    else
      render :edit
    end
  end

  

end