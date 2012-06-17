#replace :cart_item_price,                 'hooks/cart_item_price'
Deface::Override.new(
  :virtual_path => 'spree/orders/_line_item',
  :name => 'cart_item_price',
  :replace_contents => "[data-hook='cart_item_price'], #cart_item_price[data-hook]",
  :partial => "spree/hooks/cart_item_price",
  :disabled => false
)
