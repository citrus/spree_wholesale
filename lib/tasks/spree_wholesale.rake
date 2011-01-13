namespace :spree_wholesale do

  def load_environment
    puts "Loading environment..."
    require File.join(Rails.root, 'config', 'environment')
  end

  desc "Creates wholesale role"
  task :create_role do
    
    load_environment
    
    name = "wholesaler"
    role = Role.find_by_name(name) rescue nil
    if role
      puts "Role exists!"
    else
      role = Role.create(:name => name)
      puts "Role created!"
    end
    puts role.inspect
    
  end
  
  
  
  
  desc "Assumes 66% wholesale discount for each variant"
  task :assume_wholesale_prices do
    
    load_environment
    
    Variant.all.each do |variant|
      variant.wholesale_price = variant.price * 0.66
      variant.save
    end
    
  end
  
  
  
  

end