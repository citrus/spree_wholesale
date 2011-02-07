require 'test_helper'

class WholesalerTest < ActiveSupport::TestCase
  
  fixtures :all
  
  should belong_to(:user)
  should belong_to(:bill_address)
  should belong_to(:ship_address)
  
  should validate_presence_of(:company)
  should validate_presence_of(:buyer_contact)
  should validate_presence_of(:manager_contact)
  should validate_presence_of(:phone)
  should validate_presence_of(:taxid)
  
  def build_wholesaler(complete=false)
    @wholesaler ||= wholesalers(:new_wholesaler)
    return @wholesaler unless complete
    @wholesaler = add_parts(@wholesaler)
    @wholesaler.save
    @wholesaler
  end
  
  def add_parts(wholesaler=@wholesaler)
    wholesaler.user = fullsale_user
    wholesaler.bill_address = addresses(:billing)
    wholesaler.ship_address = addresses(:shipping)
    wholesaler
  end
  
  test "creates valid wholesaler" do
    build_wholesaler
    assert !@wholesaler.valid?
    add_parts
    assert @wholesaler.valid?
    assert @wholesaler.save    
  end
      
  should "activate and deactivate" do
    build_wholesaler(true)
    assert !@wholesaler.active?
    @wholesaler.activate!
    assert @wholesaler.active?
    @wholesaler.deactivate!
    assert !@wholesaler.active?
  end
  
end