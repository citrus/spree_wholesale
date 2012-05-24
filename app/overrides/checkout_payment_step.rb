#insert_before :checkout_payment_step,     'hooks/wholesale_payment_options'
Deface::Override.new(
  :virtual_path => 'spree/checkout/_payment',
  :name => 'checkout_payment_step',
  :insert_before => "[data-hook='checkout_payment_step'], #customer_payment_step[data-hook]",
  :partial => "spree/hooks/wholesale_payment_options",
  :disabled => false
)
