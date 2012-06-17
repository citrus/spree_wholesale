#insert_after :admin_orders_index_headers, 'admin/hooks/admin_orders_index_headers'
Deface::Override.new(:virtual_path => 'spree/admin/orders/index',
:name => 'admin-orders-headers',
:insert_bottom => "[data-hook='admin_orders_index_headers'], #admin_orders_index_headers[data-hook]",
:partial => "spree/admin/hooks/admin_orders_index_headers",
:disabled => false)
