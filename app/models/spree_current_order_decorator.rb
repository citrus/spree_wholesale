Spree::CurrentOrder.module_eval do

  def before_save_new_order
    
    if current_user
      @current_order.user = current_user
      @current_order.wholesale = current_user.has_role?("wholesaler")
    end
    
    #puts "before_save_new_order!!!!!"
    
    #puts current_user
    
    #puts @current_order.inspect
    
  end

end
