module SpreeWholesale
  require 'deface'
  class CustomHooks < Spree::ThemeSupport::HookListener
        
    replace :cart_item_price,                 'hooks/cart_item_price'
    replace :cart_item_total,                 'hooks/cart_item_total'
    replace :admin_product_form_right,        'admin/hooks/product_form_right'
    
    insert_before :account_my_orders,         'hooks/wholesale_customer'
    insert_before :inside_cart_form,          'hooks/wholesale_customer_id'
    insert_before :checkout_payment_step,     'hooks/wholesale_payment_options'
    insert_after  :admin_order_show_buttons,  'hooks/wholesale_customer_id'
    
    
    insert_after :admin_orders_index_headers, 'admin/hooks/admin_orders_index_headers'
    insert_after :admin_orders_index_rows,    'admin/hooks/admin_orders_index_rows'
    insert_after :admin_orders_index_search,  'admin/hooks/admin_orders_index_search'
    # insert_after :admin_tabs,                 'admin/hooks/wholesale_tab'
    Deface::Override.new(:virtual_path => 'layouts/admin',
                          :name => "admin-wholesale-tab",
                          :insert_bottom => "[data-hook='admin_tabs']",
                          :partial => "admin/hooks/wholesale_tab")
    
  end
end
