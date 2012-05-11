require 'test_helper'

class Spree::WholesalerTest < ActiveSupport::TestCase

  def setup
    # nada
  end

  should belong_to(:user)
  should belong_to(:bill_address)
  should belong_to(:ship_address)

  should validate_presence_of(:company)
  should validate_presence_of(:buyer_contact)
  should validate_presence_of(:manager_contact)
  should validate_presence_of(:phone)
  should validate_presence_of(:taxid)

  context "with a new wholesaler" do

    setup do
      @wholesaler = Factory.build(:wholesaler, :user => nil, :ship_address => nil, :bill_address => nil)
    end

    should "create valid wholesaler" do
      @wholesaler.user = Factory.create(:wholesale_user)
      @wholesaler.bill_address = @wholesaler.ship_address = Factory.create(:address)
      assert @wholesaler.valid?
      assert @wholesaler.save
    end

  end

  context "with an existing wholesaler" do

    setup do
      @wholesaler = Factory.create(:wholesaler,
        :user         => Factory.create(:wholesale_user),
        :bill_address => Factory.create(:address),
        :ship_address => Factory.create(:address)
      )
    end

    should "activate" do
      @wholesaler.roles = [Spree::Role.find_by_name("user")]

      assert !@wholesaler.active?
      @wholesaler.activate!
      assert @wholesaler.active?
    end

    should "deactivate" do
      @wholesaler.roles = [Spree::Role.find_by_name("wholesaler")]

      assert @wholesaler.active?
      @wholesaler.deactivate!
      assert !@wholesaler.active?
    end

  end


  #should "activate and deactivate" do
  #
  #  @wholesaler.deactivate!
  #  assert !@wholesaler.active?
  #end

end
