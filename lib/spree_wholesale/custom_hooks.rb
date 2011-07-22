module SpreeWholesale
  require 'deface'
  class CustomHooks < Spree::ThemeSupport::HookListener

#replace :cart_item_price,                 'hooks/cart_item_price'
Deface::Override.new(:virtual_path => 'orders/_line_item',
                          :name => 'cart_item_price',
                          :insert_before => "[data-hook='cart_item_price']",
                          :partial => "hooks/cart_item_price")
                          
#replace :cart_item_total,                 'hooks/cart_item_total'
Deface::Override.new(:virtual_path => 'orders/_line_item',
                          :name => 'cart_item_total',
                          :insert_before => "[data-hook='cart_item_total']",
                          :partial => "hooks/cart_item_total")

#replace :admin_product_form_right,        'admin/hooks/product_form_right'
Deface::Override.new(:virtual_path => 'admin/products/form',
                          :name => 'productform_right',
                          :insert_before => "[data-hook='admin_product_form_right']",
                          :partial => "admin/hooks/product_form_right")

#insert_before :account_my_orders,         'hooks/wholesale_customer'
Deface::Override.new(:virtual_path => 'users/show',
                          :name => 'wholesale-my-orders',
                          :insert_before => "[data-hook='account_my_orders']",
                          :partial => "hooks/wholesale_customer")

#insert_before :inside_cart_form,          'hooks/wholesale_customer_id'
Deface::Override.new(:virtual_path => 'orders/edit',
                          :name => 'id_inside_cartform',
                          :insert_before => "[data-hook='inside_cart_form']",
                          :partial => "hooks/wholesale_customer_id")
                          
#insert_before :checkout_payment_step,     'hooks/wholesale_payment_options'    
Deface::Override.new(:virtual_path => 'checkout/payment',
                          :name => 'checkout_payment_step',
                          :insert_before => "[data-hook='checkout_payment_step']",
                          :partial => "hooks/wholesale_payment_options")


#insert_after  :admin_order_show_buttons,  'hooks/wholesale_customer_id'
    Deface::Override.new(:virtual_path => 'orders/show',
                          :name => 'admin-order-show-buttons',
                          :insert_bottom => "[data-hook='admin_order_show_buttons']",
                          :partial => "hooks/wholesale_customer_id")


#insert_after :admin_orders_index_headers, 'admin/hooks/admin_orders_index_headers'
Deface::Override.new(:virtual_path => 'admin/orders/index',
:name => 'admin-orders-headers',
:insert_bottom => "[data-hook='admin_orders_index_headers']",
:partial => "admin/hooks/admin_orders_index_headers")

# insert_after :admin_orders_index_rows,    'admin/hooks/admin_orders_index_rows'
Deface::Override.new(:virtual_path => 'admin/orders/index',
:name => 'admin-orders-rows',
:insert_bottom => "[data-hook='admin_orders_index_rows']",
:partial => "admin/hooks/admin_orders_index_rows")

#insert_after :admin_orders_index_search,  'admin/hooks/admin_orders_index_search'
Deface::Override.new(:virtual_path => 'admin/orders/index',
:name => 'admin-orders-search',
:insert_bottom => "[data-hook='admin_orders_index_search']",
:partial => "admin/hooks/admin_orders_index_search")

# insert_after :admin_tabs,                 'admin/hooks/wholesale_tab'
Deface::Override.new(:virtual_path => 'layouts/admin',
:name => "admin-wholesale-tab",
:insert_bottom => "[data-hook='admin_tabs']",
:partial => "admin/hooks/wholesale_tab")

  end
end
