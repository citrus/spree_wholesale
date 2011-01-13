#Spree::CurrentOrder.module_eval do
#
#  def before_save_new_order
#    
#    if current_user
#      @current_order.user ||= current_user
#      @current_order.wholesale = current_user.has_role?("wholesaler")
#    end
#    
#  end
#
#end

module Spree
  module CurrentOrder

    # This should be overridden by an auth-related extension which would then have the opporutnity to associate the new order with the
    # current user before saving.
    def before_save_new_order
     if current_user
        @current_order.user ||= current_user
        @current_order.wholesale = current_user.has_role?("wholesaler")
      end
    end

    # The current incomplete order from the session for use in cart and during checkout
    def current_order(create_order_if_necessary = false)
      puts "----"
      
      puts "CURRENT ORDER:"
      puts @current_order.inspect
    
      return @current_order if @current_order
      
      puts "SETTING CURRENT ORDER"
      @current_order = Order.find_by_id(session[:order_id], :include => :adjustments)
      
      if create_order_if_necessary and (@current_order.nil? or @current_order.completed?)
        @current_order = Order.new
        before_save_new_order
        @current_order.save!
        puts "ORDER CREATED!"  
      end
      
      
      if current_user 
      
        puts current_user.inspect
        puts current_user.has_role?("wholesaler")
        puts @current_order.is_wholesale?
      
        if current_user.has_role?("wholesaler") && !@current_order.is_wholesale?
          @current_order.to_wholesale!
        elsif !current_user.has_role?("wholesaler") && @current_order.is_wholesale?
          @current_order.to_fullsale!
        end
      end
      
      
      session[:order_id] = @current_order ? @current_order.id : nil
      
      puts @current_order.inspect
      
      @current_order
    end
  end
end
