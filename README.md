Spree Wholesale
===============

Spree wholesale is a simple wholesale solution for Spree Commerce. Spree wholesale adds a wholesaler login and signup page as well as an admin to approve and deny applicants.

To install Spree Wholesale:
    
    gem install spree_wholesale
    
Or add to your Gemfile:
    
    echo "gem 'spree_wholesale', '0.40.2.2'" >> Gemfile

Or install from the source:
    
    echo "gem 'spree_wholesale', :git => 'git://github.com/citrus/spree_wholesale'" >> Gemfile

Then:

    rake spree_wholesale:install
    rake db:migrate
    rake spree_wholesale:create_role
    
      
If you'd like to generate sample wholesale prices based on a 66% discount:

    rake spree_wholesale:assume_wholesale_prices


And if you'd like run tests:
    
    git clone git://github.com/citrus/spree_wholesale.git
    cd spree_wholesale
    rake test_app
    rake

(TO DO: Write admin controller tests)


Demo
----

To create a demo of SpreeWholesaleExample

    cd ~/your/project/directory
    
    rails new spree_wholesale_example
    cd spree_wholesale_example
    
    echo "gem 'spree', '0.40.2'" >> Gemfile
    echo "gem 'spree_wholesale', '0.40.2.2'" >> Gemfile
    rm public/index.html
    
    bundle install
    
    rails g spree:site
    rake spree:install
    rake spree_wholesale:install
    rake db:migrate
    rake db:seed
    rake spree_wholesale:create_role
    
or shorthand:
    
    rails new spree_wholesale_example; cd spree_wholesale_example; echo "gem 'spree', '0.40.2'" >> Gemfile; echo "gem 'spree_wholesale', '0.40.2.2'" >> Gemfile; rm public/index.html
    rake spree:install spree_wholesale:install db:migrate db:seed spree_wholesale:create_role
  
If you want sample data:

    rake spree_sample:install db:sample 
    rake spree_wholesale:assume_wholesale_prices



Link the included stylesheet by adding `@import url('wholesale.css');` to `screen.css`.

    echo "@import url('wholesale.css');"|cat - public/stylesheets/screen.css > /tmp/out && mv /tmp/out public/stylesheets/screen.css
    

    
Then finish by booting up the rails server:

    rails s



To create the demo all in one swoop:
  
    rails new spree_wholesale_example; cd spree_wholesale_example; echo "gem 'spree', '0.40.2'" >> Gemfile; echo "gem 'spree_wholesale', '0.40.2.2'" >> Gemfile; rm public/index.html; bundle install; rake spree:install spree_wholesale:install db:migrate db:seed spree_wholesale:create_role spree_sample:install db:sample spree_wholesale:assume_wholesale_prices; echo "@import url('wholesale.css');"|cat - public/stylesheets/screen.css > /tmp/out && mv /tmp/out public/stylesheets/screen.css; rails s
    


    

License
-------

Copyright (c) 2011 Spencer Steffen, released under the New BSD License All rights reserved.