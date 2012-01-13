require 'sass'

module SpreeWholesale
  class Engine < Rails::Engine
    engine_name 'spree_wholesale'

    config.autoload_paths += %W(#{config.root}/lib)

    Sass::Engine::DEFAULT_OPTIONS[:load_paths].tap do |load_paths|
      load_paths << "#{SpreeWholesale::Engine.root}/app/assets/stylesheets"
      load_paths << "#{Gem.loaded_specs['compass'].full_gem_path}/frameworks/compass/stylesheets"
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end

      Dir.glob(File.join(File.dirname(__FILE__), "../../app/overrides/**/*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
