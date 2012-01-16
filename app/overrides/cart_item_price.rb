#replace :cart_item_price,                 'hooks/cart_item_price'
Deface::Override.new(
  :virtual_path => 'orders/_line_item',
  :name => 'cart_item_price',
  :replace_contents => "[data-hook='cart_item_price'], #cart_item_price[data-hook]",
  :partial => "hooks/cart_item_price",
  :disabled => false
)