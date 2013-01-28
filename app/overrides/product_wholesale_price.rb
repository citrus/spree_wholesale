Deface::Override.new(
  :virtual_path => 'spree/products/_cart_form',
  :name => 'product_wholesale_price',
  :insert_bottom => "#product-price",
  :partial => "spree/hooks/product_wholesale_price",
  :disabled => false
)
