ProductsHelper.module_eval do


  def wholesaler_signed_in?
    current_user && current_user.has_role?("wholesaler")
  end


  # returns the price of the product to show for display purposes
  def product_price(product_or_variant, options={})
    options.assert_valid_keys(:format_as_currency, :show_vat_text, :hide_labels, :quantity)
    options.reverse_merge! :format_as_currency => true, :show_vat_text => Spree::Config[:show_price_inc_vat]
    amount = product_or_variant.price
    amount += Calculator::Vat.calculate_tax_on(product_or_variant) if Spree::Config[:show_price_inc_vat]
    prices = [amount]
    if wholesaler_signed_in? && product_or_variant.is_wholesaleable?
      prices[0] = [prices[0], "msrp"]
      prices << [product_or_variant.wholesale_price, "wholesale"]
    end
    format_as_currency = options.delete(:format_as_currency)
    hide_labels = options.delete(:hide_labels)
    quantity = options.delete(:quantity) || 1
    prices.collect!{|price|
      if price.is_a? Array
        content_tag(:span, :class => "price_#{price[1]}") do
          price[0] *= quantity
          price[0] = format_price(price[0], options) if format_as_currency 
          price.slice!(1) if hide_labels
          price.reverse.join(": ")
        end
      else
        price *= quantity
        format_as_currency ? format_price(price, options) : price
      end
    }
    
    price = prices.first
    if format_as_currency
      prices.join(" ").html_safe
    else
      if price.is_a? Array    
        price = price.first
      end
      price.to_f
    end
  
  end
  
  
  
  def order_price(order, options={})
    options.assert_valid_keys(:format_as_currency, :show_vat_text, :show_price_inc_vat)
    options.reverse_merge! :format_as_currency => true, :show_vat_text => true

    # overwrite show_vat_text if show_price_inc_vat is false
    options[:show_vat_text] = Spree::Config[:show_price_inc_vat]

    amount =  order.item_total
    amount += Calculator::Vat.calculate_tax(order) if Spree::Config[:show_price_inc_vat]

    options.delete(:format_as_currency) ? number_to_currency(amount) : amount
  end
  
end