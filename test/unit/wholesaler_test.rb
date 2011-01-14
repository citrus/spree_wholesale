class WholesalerTest < ActiveSupport::TestCase
  
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
      
  test "wholesaler activation and deactivation" do
    build_wholesaler(true)
    assert !@wholesaler.active?
    @wholesaler.activate!
    assert @wholesaler.active?
    @wholesaler.deactivate!
    assert !@wholesaler.active?
  end
  
end