class WholesalerAbility 
  include CanCan::Ability 
  def initialize(user, controller_namespace = nil) 
    user ||= User.new 
    can :index,  Wholesaler
    can :new,    Wholesaler
    can :create, Wholesaler
    can :read,   Wholesaler do |resource|
      resource.user == user
    end
  end 
end 