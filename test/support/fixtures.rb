begin
  
  FactoryGirl.define do
    
    factory :state do
      name "California"
      abbr "CA"
      country { Country.find_by_iso("US") || Factory.create(:country) }
    end
    
    factory :country do
      name "United States"
      iso3 "USA"
      iso "US"
      iso_name { name.upcase }
      numcode 840
    end

    factory :address do
      firstname "Addy"
      lastname "Streetston"
      address1 { "#{100 + rand(1000)} State St" }
      city "Santa Barbara"
      phone "555-555-5555"
      zipcode "93101"
      state { State.find_by_name("California") || Factory.create(:state) }
      country { Country.find_by_name("United States") || Factory.create(:country) }
    end
    
    
    factory :wholesaler do
      company "Test Company"
      buyer_contact "Mr Contacter"
      manager_contact "Mr Manager"
      phone "555-555-5555"
      fax "555-555-5555 ext 1"
      resale_number "123456789"
      taxid "555-55-5555"
      web_address "testcompany.com"
      terms "Credit Card"
      notes "What a guy!"
      user { User.last || Factory.create(:user) }
      bill_address { Factory.create(:address) }
      ship_address { Factory.create(:address) }
    end
  
    
    factory :user do
      email { random_email }
      password "spree123"
      password_confirmation "spree123"
      roles { [Role.find_or_create_by_name("user")] }
    end
    
    factory :admin_user, :parent => :user do
      roles { [Role.find_or_create_by_name("admin")] }
    end
    
    factory :wholesale_user, :parent => :user do
      roles { [Role.find_or_create_by_name("wholesaler")] }
      wholesaler { Factory.create(:wholesaler) }
    end
    
    factory :order do
      user { User.last || Factory.create(:user) }
      state 'cart'
      payment_state 'balance_due'
      email { random_email }
      wholesale false
    end
    
    factory :wholesale_order, :parent => :order do
      user { Factory.create(:wholesale_user) }
      wholesale true
    end
  
  end
  
rescue FactoryGirl::DuplicateDefinitionError
  
  puts "factories are already defined..."
  
end