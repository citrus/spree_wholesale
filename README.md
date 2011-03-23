Spree Wholesale
===============

Spree wholesale is a simple wholesale solution for Spree Commerce. Spree wholesale adds a wholesaler login and signup page as well as an admin to approve and deny applicants.


Installation
------------


To install Spree Wholesale to your existing Spree store, add the following to your `Gemfile`
    
    gem 'spree_wholesale', '0.50.0.0'
    

Or if you'd rather track the source:
    
    gem 'spree_wholesale', :git => 'git://github.com/citrus/spree_wholesale'

    
Then:

    rake spree_wholesale:install db:migrate spree_wholesale:create_role
    
      
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