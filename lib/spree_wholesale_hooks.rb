class SpreeWholesaleHooks < Spree::ThemeSupport::HookListener
  
  replace :admin_product_form_right, 'admin/hooks/product_form_right'
  
  replace :cart_item_price, 'hooks/cart_item_price'
  replace :cart_item_total, 'hooks/cart_item_total'
  
  insert_before :inside_cart_form, 'hooks/wholesale_customer_id'
  
  insert_after :admin_order_show_buttons, 'hooks/wholesale_customer_id'
  
  insert_after :admin_orders_index_headers, 'admin/hooks/admin_orders_index_headers'
  insert_after :admin_orders_index_rows,    'admin/hooks/admin_orders_index_rows'
  insert_after :admin_orders_index_search,  'admin/hooks/admin_orders_index_search'
  insert_after :admin_tabs,  'admin/hooks/wholesale_tab'
  
end