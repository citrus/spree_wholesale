User.instance_eval do 
  
  has_one :wholesaler
    
  scope :wholesale, lambda { includes(:roles).where("roles.name" => "wholesaler") }

    
end

User.class_eval do 
  
  def wholesaler?
    has_role?("wholesaler") && !wholesaler.nil?
  end
  
end