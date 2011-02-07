if ENV["RAILS_ENV"] != "production"
  require 'spree_core'
  require 'spree_auth'
  require 'sqlite3'
end

require 'spree_wholesale_hooks'
require 'spree_wholesale/wholesaler_controller'

module SpreeWholesale  
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    initializer "static assets" do |app|
      app.middleware.insert_before ::Rack::Lock, ::ActionDispatch::Static, "#{config.root}/public"
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
    
  end
end