#replace :admin_product_form_right,        'admin/hooks/product_form_right'
Deface::Override.new(
  :virtual_path => 'spree/admin/products/_form',
  :name => 'admin_product_form_right',
  :insert_top => "[data-hook='admin_product_form_right']",
  :partial => "spree/admin/hooks/product_form_right",
  :disabled => false
)
