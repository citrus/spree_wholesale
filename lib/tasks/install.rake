namespace :spree_wholesale do

  desc "Copies all migrations and assets (NOTE: This will be obsolete with Rails 3.1)"
  task :install do
    Rake::Task['spree_wholesale:install:migrations'].invoke
    Rake::Task['spree_wholesale:install:assets'].invoke
  end

  namespace :install do
    desc "Copies all migrations (NOTE: This will be obsolete with Rails 3.1)"
    task :migrations do
      source = File.expand_path('../../../db/migrate', __FILE__)
      destination = File.join(Rails.root, 'db', 'migrate')
      
      last_migration = Dir.entries(destination).last
      migration      = (last_migration.match(/[0-9]+/) || [])[0].to_i
      
      Dir.entries(source).select{|file| file.match('.rb') }.each do |file|
        src = File.join(source, file)
        dst = File.join(destination, "#{(migration += 5)}_#{file}")
        FileUtils.cp(src, dst)
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