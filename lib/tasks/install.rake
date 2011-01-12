namespace :spree_wholesale do

  desc "load environment"
  task :load_environment do
    puts "loading environment..."
    require File.join(Rails.root, 'config', 'environment')
  end

  desc "Copies all migrations and assets (NOTE: This will be obsolete with Rails 3.1)"
  task :install do
    Rake::Task['spree_wholesale:install:migrations'].invoke
    Rake::Task['spree_wholesale:install:assets'].invoke
  end
  
  
  
  desc "Creates wholesale role"
  task :create_role do
    
    Rake::Task['spree_wholesale:load_environment'].invoke
    
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
  
  
  
  
  desc "Creates wholesale role"
  task :assume_wholesale_prices do
    
    Rake::Task['spree_wholesale:load_environment'].invoke
    
    Variant.all.each do |variant|
      variant.wholesale_price = variant.price * 0.66
      variant.save
    end
    
  end
  
  

  namespace :install do
    desc "Copies all migrations (NOTE: This will be obsolete with Rails 3.1)"
    task :migrations do
    
      source = File.expand_path('../../../db/migrate', __FILE__)
      destination = File.join(Rails.root, 'db', 'migrate')
      migrations = Dir.entries(destination).select{|file| file.match('.rb') }
      
      files = Dir.entries(source).select{|file| file.match('.rb') }
      files.each_with_index do |file,index|
        time = Time.now + (index * 7)
        number = [time.utc.strftime("%Y%m%d%H%M%S"), "%.14d" % index].max
        new_file = [number,file].join('_')
        src = File.join(source, file)
        dst = File.join(destination, new_file)
        if 0 < migrations.select{|migration| migration.match(file) != nil }.length
          puts "#{file} exists!"
        else
          FileUtils.cp(src, dst)
          puts "#{new_file} copied!"
        end
      end
    end

    desc "Copies all assets (NOTE: This will be obsolete with Rails 3.1)"
    task :assets do
      source = File.join(File.dirname(__FILE__), '..', '..', 'public')
      destination = File.join(Rails.root, 'public')
      puts "INFO: Mirroring assets from #{source} to #{destination}"
      Spree::FileUtilz.mirror_files(source, destination)
    end
  end

end