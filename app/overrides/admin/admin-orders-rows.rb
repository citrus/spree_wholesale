# insert_after :admin_orders_index_rows,    'admin/hooks/admin_orders_index_rows'
Deface::Override.new(:virtual_path => 'spree/admin/orders/index',
:name => 'admin-orders-rows',
:insert_bottom => "[data-hook='admin_orders_index_rows'], #admin_orders_index_rows[data-hook]",
:partial => "spree/admin/hooks/admin_orders_index_rows",
:disabled => false)
