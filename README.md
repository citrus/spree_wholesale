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
    echo "gem 'spree_wholesale', '0.40.0.beta2'" >> Gemfile
    
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
    echo "gem 'spree_wholesale', '0.40.0.beta2.3'" >> Gemfile
    rm public/index.html

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
  
    rails new spree_wholesale_example; cd spree_wholesale_example; echo "gem 'spree', '0.40.0'" >> Gemfile; echo "gem 'spree_wholesale', '0.40.0.beta2.3'" >> Gemfile; rm public/index.html; rake spree:install spree_wholesale:install db:migrate db:seed spree_wholesale:create_role spree_sample:install db:sample spree_wholesale:assume_wholesale_prices; echo "@import url('wholesale.css');"|cat - public/stylesheets/screen.css > /tmp/out && mv /tmp/out public/stylesheets/screen.css; rails s
    

    

License
-------

Copyright (c) 2011 Spencer Steffen, released under the New BSD License
All rights reserved.

>Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

> Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

> Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation - and/or other materials provided with the distribution.

> Neither the name of the <ORGANIZATION> nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.