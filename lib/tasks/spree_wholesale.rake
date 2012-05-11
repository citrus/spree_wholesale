namespace :spree_wholesale do
  def load_environment
    puts "Loading environment..."
    require File.join(Rails.root, 'config', 'environment')
  end

  desc "Creates wholesale role"
  task :create_role do
    load_environment

    name = "wholesaler"
    role = Spree::Role.find_by_name(name) rescue nil
    if role
      puts "Role exists!"
    else
      role = Spree::Role.create(:name => name)
      puts "Role created!"
    end

    puts role.inspect
  end

  desc "Assumes 50% wholesale discount for each variant"
  task :assume_wholesale_prices do
    load_environment

    Spree::Variant.all.each do |variant|
      price = variant.price * 0.5
      ActiveRecord::Base.connection.execute("UPDATE spree_variants SET wholesale_price = #{price} WHERE id = #{variant.id}")
    end
  end
end
