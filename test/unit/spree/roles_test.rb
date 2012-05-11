require 'test_helper'

class Spree::RolesTest < ActiveSupport::TestCase

  should "find or create wholesale role" do
    role = Spree::Role.find_or_create_by_name("wholesaler")
    assert !role.nil?, "Wholesale role does not exist."
  end

end
