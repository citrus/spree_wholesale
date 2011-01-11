require 'spree_core'
require 'spree_wholesale_hooks'

module SpreeWholesale
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
    
      Product.instance_eval do 
        delegate_belongs_to :master, :wholesale_price if Variant.table_exists? && Variant.column_names.include?("wholesale_price")
      end 
    
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
