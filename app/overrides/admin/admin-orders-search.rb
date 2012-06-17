#insert_after :admin_orders_index_search,  'admin/hooks/admin_orders_index_search'
Deface::Override.new(:virtual_path => 'spree/admin/orders/index',
:name => 'admin-orders-search',
:insert_before => "[data-hook='admin_orders_index_search_buttons']",
:partial => "spree/admin/hooks/admin_orders_index_search",
:disabled => false)
