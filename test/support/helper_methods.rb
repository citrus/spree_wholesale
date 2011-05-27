module HelperMethods 

  def random_email
    random_token.split("").insert(random_token.length / 2, "@").push(".com").join("")
  end
  
  def random_token
    Digest::SHA1.hexdigest((Time.now.to_i * rand).to_s)
  end
  
end

#  PRICE = BigDecimal.new("19.99")
#  WHOLESALE = BigDecimal.new("18.00")
#
#  EMAIL = "spree@example.com"
#  PASSWORD = "spree123"
#
#  def fullsale_user
#    return @wholesale_user if @wholesale_user
#    email = "fullsale@example.com"
#    @fullsale_user = User.create(:email => email, 
#      :password => PASSWORD,
#      :password_confirmation => PASSWORD,
#      :email => email,
#      :login => email
#    )
#    @fullsale_user.roles << roles(:user)
#    @fullsale_user
#  end
#  
#  def wholesale_user
#    return @wholesale_user if @wholesale_user
#    @wholesale_user = User.find_by_email("spree@example.com") rescue nil
#    unless @wholesale_user
#      @wholesale_user = User.new(
#        :password => PASSWORD,
#        :password_confirmation => PASSWORD,
#        :email => EMAIL,
#        :login => EMAIL
#      )
#      @wholesale_user.roles << roles(:user) unless @wholesale_user.has_role?("user")
#      @wholesale_user.roles << roles(:wholesaler) unless @wholesale_user.has_role?("wholesaler")
#      @wholesale_user.save
#    end
#    @wholesale_user
#  end
#  
#end