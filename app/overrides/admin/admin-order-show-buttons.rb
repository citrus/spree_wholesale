#insert_after  :admin_order_show_buttons,  'hooks/wholesale_customer_id'
Deface::Override.new(:virtual_path => 'orders/show',
:name => 'admin-order-show-buttons',
:insert_after => "[data-hook='admin_order_show_buttons'], #admin_order_show_buttons[data-hook]",
:partial => "hooks/wholesale_customer_id",
:disabled => false)
