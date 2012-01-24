module SpreeWholesale
  module Generators
    class InstallGenerator < Rails::Generators::Base
      
      class_option :skip_migrations, :type => :boolean, :default => false, :description => "Skips the `run_migrations` step" 
      
      desc "Installs required stylesheets, javascripts and migrations for spree_wholesale"
          
      def add_javascripts
        append_file "app/assets/javascripts/store/all.js", "//= require wholesaler_address\n"
        append_file "app/assets/javascripts/admin/all.js", "//= require wholesaler_address\n"
      end

      def add_stylesheets
        inject_into_file "app/assets/stylesheets/store/all.css", " *= require store/wholesale\n", :before => /\*\//, :verbose => true
        inject_into_file "app/assets/stylesheets/admin/all.css", " *= require admin/wholesalers\n", :before => /\*\//, :verbose => true
      end
      
      def install_migrations
        puts "Copying migrations..."
        cmd = "bundle exec rake railties:install:migrations FROM=spree_wholesale"
        silence_stream(STDOUT) do
          silence_warnings do
            run cmd
          end
        end
      end
      
      def run_migrations
        return if options[:skip_migrations]
        res = ask "Would you like to run the migrations now? [Y/n]"
        if res == "" || res.downcase == "y"
          run 'bundle exec rake db:migrate'
        else
          puts "Skipping rake db:migrate, don't forget to run it!"
        end
      end
      
    end
  end
end
