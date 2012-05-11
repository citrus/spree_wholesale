module SpreeWholesale
  class Engine < Rails::Engine

    engine_name "spree_wholesale"

    config.autoload_paths += %W(#{config.root}/lib)

    class WholesalerAbility
      include CanCan::Ability

      def initialize(user)
        user ||= User.new
        can :index,  Spree::Wholesaler
        can :new,    Spree::Wholesaler
        can :create, Spree::Wholesaler
        can :read,   Spree::Wholesaler do |resource|
          resource.user == user || user.has_role?(:admin)
        end
        can :update, Spree::Wholesaler do |resource|
          resource.user == user || user.has_role?(:admin)
        end

      end
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end

      Dir.glob(File.join(File.dirname(__FILE__), "../../app/overrides/**/*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end

      Spree::Ability.register_ability(WholesalerAbility)
    end

    config.to_prepare &method(:activate).to_proc
  end
end
