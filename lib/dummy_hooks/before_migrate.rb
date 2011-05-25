# a hack to make rails 3.0.7 work with rake 0.9.0
prepend_file 'config/application.rb', %(require "rake"
)

# install spree and migrate db

say_status "installing", "spree_core, spree_auth and spree_sample"
rake "spree_core:install spree_auth:install spree_sample:install"

say_status "installing", "spree_wholesale"
run "rails g spree_wholesale:install"
