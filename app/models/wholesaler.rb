class Wholesaler < ActiveRecord::Base
  
  partial_updates = false
  
  belongs_to :user, :dependent => :destroy  
  belongs_to :bill_address, :foreign_key => "billing_address_id", :class_name => "Address", :dependent => :destroy
  belongs_to :ship_address, :foreign_key => "shipping_address_id", :class_name => "Address", :dependent => :destroy
  
  validates :company, :buyer_contact, :manager_contact, :phone, :taxid, :presence => true
  validate :validate_parts
    
  delegate_belongs_to :user, :roles
  delegate_belongs_to :user, :email
    
  def validate_parts
    uv = user && user.valid? 
    bv = bill_address && bill_address.valid?
    sv = ship_address && ship_address.valid?
    self.errors.add(:base, I18n.t("wholesaler.parts_error_message")) unless uv && bv && sv
  end
    
  def activate!
    get_wholesale_role
    return false if user.roles.include?(@role)
    user.roles << @role
    user.save
  end
  
  def deactivate!
    get_wholesale_role
    return false unless user.roles.include?(@role)
    user.roles.delete(@role)
    user.save
  end
  
  def active?
    user && user.has_role?("wholesaler")
  end
  
  def self.term_options
    %(Net 10, Net 15, Net 30, COD, Credit Card).split(", ")
  end
  
  private
  
    def get_wholesale_role
      @role = Role.find_by_name("wholesaler")
    end
  
end