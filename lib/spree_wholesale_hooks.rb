class SpreeWholesaleHooks < Spree::ThemeSupport::HookListener
  # custom hooks go here
  
  replace :admin_product_form_right, 'admin/hooks/product_form_right'
  
end