require 'generators/base'

module SpreeWholesale
  module Generators
    class InstallGenerator < SpreeWholesale::Generators::Base
      
      desc "Installs required migrations for spree_wholesale"
      source_root File.expand_path("../../templates", __FILE__)
      
      def copy_migrations
        migration_template "db/migrate/install_spree_wholesale.rb", "db/migrate/install_spree_wholesale.rb"
      end

    end
  end
end