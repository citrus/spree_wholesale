#module WholesaleProductsHelper
#
#  # returns the price of the product to show for display purposes
#  def product_price(product_or_variant, options={})
#    options.assert_valid_keys(:format_as_currency, :show_vat_text)
#    options.reverse_merge! :format_as_currency => true, :show_vat_text => Spree::Config[:show_price_inc_vat]
#
#    puts "-----"
#    puts current_user.roles.inspect
#    
#    if current_user.has_role?("wholesaler")
#      _amount = product_or_variant.wholesale_price
#      amount = _amount if 0.0 < _amount
#    end
#    
#    amount ||= product_or_variant.price
#    
#    
#    
#    amount += Calculator::Vat.calculate_tax_on(product_or_variant) if Spree::Config[:show_price_inc_vat]
#    options.delete(:format_as_currency) ? format_price(amount, options) : amount
#  end
#  
#end
#
#ProductsHelper.send(:include, WholesaleProductsHelper)