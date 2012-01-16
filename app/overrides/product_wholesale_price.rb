Deface::Override.new(
  :virtual_path => 'products/_cart_form',
  :name => 'product_wholesale_price',
  :insert_bottom => "#product-price",
  :partial => "hooks/product_wholesale_price",
  :disabled => false
)