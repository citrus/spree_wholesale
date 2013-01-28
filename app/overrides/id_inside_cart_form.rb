#insert_before :inside_cart_form,          'hooks/wholesale_customer_id'
Deface::Override.new(
  :virtual_path => 'spree/orders/edit',
  :name => 'id_inside_cartform',
  :insert_before => "[data-hook='inside_cart_form'], #inside_cart_form[data-hook]",
  :partial => "spree/hooks/wholesale_customer_id",
  :disabled => false
)
