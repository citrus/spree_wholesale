Deface::Override.new( :virtual_path => 'spree/orders/show',
                      :name => 'wholesale_id_in_show_order',
                      :insert_before => "div#order[data-hook]",
                      :text => %q{
  <%= render 'spree/hooks/wholesale_customer_id' %>
		      },
                      :disabled => false)
