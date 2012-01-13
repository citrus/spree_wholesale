require 'deface'  
  
#Hooks have been replaced by Deface overrides
#Check out https://github.com/railsdog/deface for a quick overview of how it works and how to use it.
#

#replace :cart_item_price,                 'hooks/cart_item_price'
Deface::Override.new(:virtual_path => 'orders/_line_item',
:name => 'cart_item_price',
:replace => "[data-hook='cart_item_price'], #cart_item_price[data-hook]",
:partial => "hooks/cart_item_price",
:disabled => false)

#replace :cart_item_total,                 'hooks/cart_item_total'
Deface::Override.new(:virtual_path => 'orders/_line_item',
:name => 'cart_item_total',
:replace => "[data-hook='cart_item_total'], #cart_item_total[data-hook]",
:partial => "hooks/cart_item_total",
:disabled => false)

#replace :admin_product_form_right,        'admin/hooks/product_form_right'
Deface::Override.new(:virtual_path => 'admin/products/form',
:name => 'productform_right',
:replace => "[data-hook='admin_product_form_right'], #admin_product_form_right[data-hook]",
:partial => "admin/hooks/product_form_right",
:disabled => false)

#insert_before :account_my_orders,         'hooks/wholesale_customer'
Deface::Override.new(:virtual_path => 'users/show',
:name => 'wholesale-my-orders',
:insert_before => "[data-hook='account_my_orders'], #account_my_orders[data-hook]",
:partial => "hooks/wholesale_customer",
:disabled => false)

#insert_before :inside_cart_form,          'hooks/wholesale_customer_id'
Deface::Override.new(:virtual_path => 'orders/edit',
:name => 'id_inside_cartform',
:insert_before => "[data-hook='inside_cart_form'], #inside_cart_form[data-hook]",
:partial => "hooks/wholesale_customer_id",
:disabled => false)

#insert_before :checkout_payment_step,     'hooks/wholesale_payment_options'
Deface::Override.new(:virtual_path => 'checkout/payment',
:name => 'checkout_payment_step',
:insert_before => "[data-hook='checkout_payment_step'], #customer_payment_step[data-hook]",
:partial => "hooks/wholesale_payment_options",
:disabled => false)


#insert_after  :admin_order_show_buttons,  'hooks/wholesale_customer_id'
Deface::Override.new(:virtual_path => 'orders/show',
:name => 'admin-order-show-buttons',
:insert_after => "[data-hook='admin_order_show_buttons'], #admin_order_show_buttons[data-hook]",
:partial => "hooks/wholesale_customer_id",
:disabled => false)


#insert_after :admin_orders_index_headers, 'admin/hooks/admin_orders_index_headers'
Deface::Override.new(:virtual_path => 'admin/orders/index',
:name => 'admin-orders-headers',
:insert_bottom => "[data-hook='admin_orders_index_headers'], #admin_orders_index_headers[data-hook]",
:partial => "admin/hooks/admin_orders_index_headers",
:disabled => false)

# insert_after :admin_orders_index_rows,    'admin/hooks/admin_orders_index_rows'
Deface::Override.new(:virtual_path => 'admin/orders/index',
:name => 'admin-orders-rows',
:insert_bottom => "[data-hook='admin_orders_index_rows'], #admin_orders_index_rows[data-hook]",
:partial => "admin/hooks/admin_orders_index_rows",
:disabled => false)

#insert_after :admin_orders_index_search,  'admin/hooks/admin_orders_index_search'
Deface::Override.new(:virtual_path => 'admin/orders/index',
:name => 'admin-orders-search',
:insert_bottom => "[data-hook='admin_orders_index_search'], #admin_orders_index_search[data-hook]",
:partial => "admin/hooks/admin_orders_index_search",
:disabled => false)

# insert_after :admin_tabs,                 'admin/hooks/wholesale_tab'
# This override targets the list which wraps the admin_tabs hook. It's not matching for some reason in
# spree 0.60.0 when set directly onto the admin_tabs hook, so this is the workaround.
Deface::Override.new(:virtual_path => "layouts/admin",
:name => "admin-wholesale-tab-ul",
:insert_bottom => "div#admin-menu ul",
:partial => "admin/hooks/wholesale_tab",
:disabled => false)


# insert_after :admin_tabs,                 'admin/hooks/wholesale_tab'
# This is the 'proper' way of accessing the admin_tabs hook, but it doesn't work for me, hence above.
# DISABLED
Deface::Override.new(:virtual_path => "layouts/admin",
:name => "admin-wholesale-tab",
:insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
:partial => "admin/hooks/wholesale_tab",
:disabled => true)

