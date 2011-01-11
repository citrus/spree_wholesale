# add custom rake tasks here

desc "Creates the wholesale user role"
task :create_role do

  role = Role.find_or_create_by_name("wholesaler")  
  puts "Saved? #{role.save}"
  
end