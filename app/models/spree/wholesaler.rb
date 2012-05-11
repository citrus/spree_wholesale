class Spree::Wholesaler < ActiveRecord::Base
  partial_updates = false

  attr_accessible :bill_address_attributes, :ship_address_attributes, :user_attributes,
                  :ship_address, :bill_address,
                  :company, :buyer_contact, :manager_contact, :phone, :fax, :resale_number,
                  :taxid, :web_address, :terms, :notes, :use_billing

  belongs_to :user, :class_name => "Spree::User"
  belongs_to :bill_address, :foreign_key => "billing_address_id", :class_name => "Spree::Address", :dependent => :destroy
  belongs_to :ship_address, :foreign_key => "shipping_address_id", :class_name => "Spree::Address", :dependent => :destroy

  accepts_nested_attributes_for :bill_address
  accepts_nested_attributes_for :ship_address
  accepts_nested_attributes_for :user

  attr_accessor :use_billing
  before_validation :clone_billing_address, :if => "@use_billing"
  validates :company, :buyer_contact, :manager_contact, :phone, :taxid, :presence => true

  delegate_belongs_to :user, :roles
  delegate_belongs_to :user, :email

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
    @role = Spree::Role.find_or_create_by_name("wholesaler")
  end

  def clone_billing_address
    if bill_address and self.ship_address.nil?
      self.ship_address = bill_address.clone
    else
      self.ship_address.attributes = bill_address.attributes.except("id", "updated_at", "created_at")
    end
    true
  end
end
