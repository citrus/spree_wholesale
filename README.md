Spree Wholesale
===============

Spree wholesale is a simple wholesale solution for Spree Commerce. Spree wholesale adds a wholesaler login and signup page as well as an admin to approve and deny applicants.


Installation
------------


If you're on Spree 0.50.0 and above, you'll have to install Spree Wholesale from the source since I haven't released it yet. Just add this to your Gemfile:

    gem 'spree_wholesale', :git => 'git://github.com/citrus/spree_wholesale'

Otherwise just use the last stable release:
    
    gem 'spree_wholesale', '0.40.2.2'
    
    
Then install the necessary migrations, db:migrate, and create the wholesale role:

    rails g spree_wholesale:install
    rake db:migrate spree_wholesale:create_role
    
      
If you'd like to generate sample wholesale prices based on a 66% discount:

    rake spree_wholesale:assume_wholesale_prices



Testing
-------

If you'd like to run tests:
    
    git clone git://github.com/citrus/spree_wholesale.git
    cd spree_wholesale
    rake test_app
    rake


To Do
-----

* Write more/better tests
* Finish i18n implementation 

    

License
-------

Copyright (c) 2011 Spencer Steffen, released under the New BSD License All rights reserved.