Deface::Override.new( :virtual_path => 'spree/shared/_store_menu',
                      :name => 'wholesale_in_store_menu',
                      :insert_after => "li#home-link[data-hook]",
                      :text => %q{<li><%= link_to t("wholesalers") , spree.wholesalers_path %></li>
		      },
                      :disabled => false)
