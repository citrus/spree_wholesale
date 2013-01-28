Deface::Override.new( :virtual_path => 'spree/checkout/_summary',
                      :name => 'wholesale_id_in_checkout_summary',
                      :insert_before => "[data-hook='order_summary']",
                      :text => %q{
  <%= render 'spree/hooks/wholesale_customer_id' %>
		      },
                      :disabled => false)
