require 'generators/base'

module SpreeWholesale
  module Generators
    class UpgradeGenerator < SpreeWholesale::Generators::Base
      
      desc "Upgrades an existing spree_wholesale installation"
      source_root File.expand_path("../../templates", __FILE__)
      
      def copy_migrations
        migration_template "db/migrate/upgrade_spree_wholesale.rb", "db/migrate/upgrade_spree_wholesale.rb"
      end

    end
  end
end