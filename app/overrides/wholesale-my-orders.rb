#insert_before :account_my_orders,         'hooks/wholesale_customer'
Deface::Override.new(:virtual_path => 'spree/users/show',
:name => 'wholesale-my-orders',
:insert_before => "[data-hook='account_my_orders'], #account_my_orders[data-hook]",
:partial => "spree/hooks/wholesale_customer",
:disabled => false)
