class Wholesaler < ActiveRecord::Base
  
  belongs_to :user
  
  belongs_to :ship_address, :foreign_key => "shipping_address_id", :class_name => "Address"
  belongs_to :bill_address, :foreign_key => "billing_address_id", :class_name => "Address"
  
  validates_presence_of [ :company, :buyer_contact, :manager_contact, :phone, :taxid ]

  validates_each :user_id, :billing_address_id, :shipping_address_id do |record,attr,value|
    record.errors.add attr, 'must not contain any errors.' if value.to_i == 0
  end
  
  delegate_belongs_to :user, :roles
  delegate_belongs_to :user, :email
  
  def self.term_options
    %(Net 10, Net 15, Net 30, COD, Credit Card).split(", ")
  end
  
end