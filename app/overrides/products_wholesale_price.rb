Deface::Override.new(
  :virtual_path => 'spree/shared/_products',
  :name => 'products_wholesale_price',
  :insert_after => "[data-hook='products_list_item'] .price.selling",
  :partial => "spree/hooks/products_wholesale_price",
  :disabled => false
)
