class RolesTest < ActiveSupport::TestCase
    
  test "wholesaler role exists?" do
    role = Role.find_by_name("wholesaler")
    assert !role.nil?, "Wholesale role does not exist."
  end

end