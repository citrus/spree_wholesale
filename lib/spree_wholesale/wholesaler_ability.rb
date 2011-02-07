class WholesalerAbility
  
  include CanCan::Ability 
  
  def initialize(user) 
    user ||= User.new 
    can :index,  Wholesaler
    can :new,    Wholesaler
    can :create, Wholesaler
    can :read,   Wholesaler do |resource|
      resource.user == user
    end    
  end
  
end

Ability.register_ability(WholesalerAbility)