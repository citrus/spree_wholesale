Spree Wholesale
---------------


Currently still under development! Check back soon for more details..

To setup a fresh Spree store follow [these instructions](https://github.com/railsdog/spree/#readme).


To get spree_wholesale up and running on your spree store, do one of the following:


Install from the source:
    
    cd your/spree/project
    git clone git://github.com/citrus/spree_wholesale.git
    echo "gem 'spree_wholesale', :path => './spree_wholesale'" >> Gemfile
    
Or install the (beta) gem:
    
    gem install spree_wholesale --pre
    echo "gem 'spree_wholesale', '0.40.0.beta3'" >> Gemfile
    
    rake spree_wholesale:install
    rake db:migrate
    rake spree_wholesale:create_role

If you want to generate sample wholesale prices:

    rake spree_wholesale:assume_wholesale_prices

This will assume 66% wholesale discount.


If you'd like run tests, install from the source, then run:
  
    cd your/spree/project/spree_wholesale
    rake

(TO DO: Write some more tests!)


Demo
----

To create a demo of SpreeWholesaleExample

    cd ~/your/project/directory
    
    rails new spree_wholesale_example
    cd spree_wholesale_example
    
    echo "gem 'spree', '0.40.0'" >> Gemfile
    echo "gem 'spree_wholesale', '0.40.0.beta3'" >> Gemfile
    rm public/index.html
    
    bundle install
    
    rails g spree:site
    rake spree:install
    rake spree_wholesale:install
    rake db:migrate
    rake db:seed
    rake spree_wholesale:create_role
    
or shorthand:
    
    rails new spree_wholesale_example; cd spree_wholesale_example; echo "gem 'spree', '0.40.0'" >> Gemfile; echo "gem 'spree_wholesale', '0.40.0.beta2.3'" >> Gemfile; rm public/index.html
    rake spree:install spree_wholesale:install db:migrate db:seed spree_wholesale:create_role
  
If you want sample data:

    rake spree_sample:install db:sample 
    rake spree_wholesale:assume_wholesale_prices



Link the included stylesheet by adding `@import url('wholesale.css');` to `screen.css`.

    echo "@import url('wholesale.css');"|cat - public/stylesheets/screen.css > /tmp/out && mv /tmp/out public/stylesheets/screen.css
    

    
Then finish by booting up the rails server:

    rails s


All in one swoop:
  
    rails new spree_wholesale_example; cd spree_wholesale_example; echo "gem 'spree', '0.40.0'" >> Gemfile; echo "gem 'spree_wholesale', '0.40.0.beta2.3'" >> Gemfile; rm public/index.html; bundle install; rake spree:install spree_wholesale:install db:migrate db:seed spree_wholesale:create_role spree_sample:install db:sample spree_wholesale:assume_wholesale_prices; echo "@import url('wholesale.css');"|cat - public/stylesheets/screen.css > /tmp/out && mv /tmp/out public/stylesheets/screen.css; rails s
    


Once the server has loaded add the wholesaler role to your wholesale user(s). Navigate back to the store and check the prices!


    

License
-------

Copyright (c) 2011 Spencer Steffen, released under the New BSD License All rights reserved.