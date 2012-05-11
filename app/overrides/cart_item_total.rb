#replace :cart_item_total,                 'hooks/cart_item_total'
Deface::Override.new(:virtual_path => 'orders/_line_item',
:name => 'cart_item_total',
:replace_contents => "[data-hook='cart_item_total'], #cart_item_total[data-hook]",
:partial => "hooks/cart_item_total",
:disabled => false)
