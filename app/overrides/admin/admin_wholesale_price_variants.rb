Deface::Override.new( :virtual_path => 'spree/admin/variants/_form',
                      :name => 'admin_wholesale_price_variants',
                      :insert_before => "[data-hook='cost_price']",
                      :text => %q{
    <p data-hook="wholesale_price"><%= f.label :wholesale_price, t(:wholesale_price) %>:<br />
    <%= f.text_field :wholesale_price, :value => number_with_precision(@variant.wholesale_price, :precision => 2) %></p>
		      },
                      :disabled => false)
