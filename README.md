Spree Wholesale
==============

Currently still under development! Check back soon for more details..

To get SpreeWholesale up and running on your spree store:

    cd your/spree/project
    git clone git://github.com/citrus/spree_wholesale.git
    echo "gem 'spree_wholesale', :path => './spree_wholesale'" >> Gemfile
    rake spree_wholesale:install
    rake db:migrate
    rake spree_wholesale:create_role

If you want to generate sample wholesale prices:

    rake spree_wholesale:assume_wholesale_prices

This will assume 66% wholesale mark off.



If you'd like run tests:

    cd your/spree/project/SpreeWholesale
    rake



Copyright (c) 2011 Spencer Steffen, released under the New BSD License
