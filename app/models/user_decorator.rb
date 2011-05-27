User.instance_eval do 
  
  has_one :wholesaler
    
end

User.class_eval do 
  
  def wholesaler?
    has_role?("wholesaler") && !wholesaler.nil?
  end
  
end