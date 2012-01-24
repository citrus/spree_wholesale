run "rails g spree:site"

# remove all stylesheets except core  
%w(admin store).each do |ns|
  js  = "app/assets/javascripts/#{ns}/all.js"
  css = "app/assets/stylesheets/#{ns}/all.css"
  remove_file js
  remove_file css
  template "#{ns}/all.js", js
  template "#{ns}/all.css", css
end

run "rails g spree_wholesale:install --skip_migrations"
