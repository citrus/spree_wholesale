# assume wholesale prices
rake "db:migrate db:seed db:sample spree_wholesale:assume_wholesale_prices", :env => "development"
