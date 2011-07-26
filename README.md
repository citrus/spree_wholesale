Spree Wholesale
===============

Spree wholesale is a simple wholesale solution for Spree Commerce. Spree wholesale adds a wholesaler login and signup page as well as an admin to approve and deny applicants.


Installation
------------


If you're on Spree 0.50.0 and above, you'll have to install Spree Wholesale from the source since I haven't released it yet. Just add this to your Gemfile:

    # spree 0.70.x
    gem 'spree_wholesale', :git => 'git://github.com/citrus/spree_wholesale'
    
    # spree 0.60.x
    gem 'spree_wholesale', :git => 'git://github.com/citrus/spree_wholesale', :branch => '0.60.x'
    
    # spree 0.50.x
    gem 'spree_wholesale', :git => 'git://github.com/citrus/spree_wholesale', :branch => '0.50.x'
    

Otherwise just use the last stable release:
    
    gem 'spree_wholesale', '0.40.2.2'
    
    
Then install the necessary migrations, db:migrate, and create the wholesale role:

    # spree 0.50.x and above
    rails g spree_wholesale:install
    rake db:migrate spree_wholesale:create_role

    # legacy spree
    rake spree_wholesale:install
    rake db:migrate spree_wholesale:create_role
      
      
If you'd like to generate sample wholesale prices based on a 66% discount:

    rake spree_wholesale:assume_wholesale_prices



Testing
-------

If you'd like to run tests:
    
    git clone git://github.com/citrus/spree_wholesale.git
    cd spree_wholesale
    bundle install
    bundle exec dummier
    bundle exec rake


Demo
----

If you'd like a demo of spree_wholesale:
    
    git clone git://github.com/citrus/spree_wholesale.git
    cd spree_wholesale
    mv test/dummy_hooks/after_migrate.rb.sample mv test/dummy_hooks/after_migrate.rb
    bundle install
    bundle exec dummier
    cd test/dummy
    rails s
    


To Do
-------

* Write more/better tests
* Finish i18n implementation 


Known Issues
-------

* A user created in the 'user' tab, or an already existing user with an added 'wholesaler' flag will not be able to purchase at wholesale price. They will see the retail and wholesale price, but when added to cart will purchase at retail price. Only accounts created using wholesale interface work properly.
* Deface override for admin_tabs (Adds wholesalers tab to admin interface) isn't targeting hook correctly, and has been set to insert to bottom of the div#store-menu ul instead.


Contributors
------------

* Spencer Steffen ([@citrus](https://github.com/citrus))
* Cameron Carroll ([@sanarothe](https://github.com/sanarothe))


License
-------

Copyright (c) 2011 Spencer Steffen and Citrus, released under the New BSD License All rights reserved.
