# install spree and migrate db

say_status "installing", "spree_core, spree_auth and spree_sample"
rake "spree_core:install spree_auth:install spree_sample:install"

say_status "installing", "spree_wholesale"
run "rails g spree_wholesale:install"