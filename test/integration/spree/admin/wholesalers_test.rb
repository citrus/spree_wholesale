require 'test_helper'

class Spree::Admin::WholesalersTest < ActiveSupport::IntegrationCase

  def setup
    Factory.create(:state)

    @user = Factory.create(:admin_user)
    login_as @user

    @labels = %(Company, Buyer contact, Manager contact, Phone, Fax, Resale number, Taxid, Web address, Notes).split(', ')
    @values = %(Some Company, Buyer contact, Manager contact, 555-555-5555, 555-555-5555 ext 1, 12345, 123-45-6789, example.com, Yippee!).split(', ')
    @address_labels = %(First Name, Last Name, Street Address, City, Zip, Phone).split(', ')
    @address_values = %(Billy, Billerton, 111 State St, Santa Barbara, 93101, 555-555-5555).split(', ')
  end

  should "have a link to new wholesaler" do
    visit spree.admin_wholesalers_path
    btn = find(".actions a.button").native
    assert_match(/#{spree.new_admin_wholesaler_path}$/, btn.attribute('href'))
    assert_equal "New Wholesaler", btn.text
  end

  should "get new wholesaler" do
    visit spree.new_admin_wholesaler_path
    # assert has_content?("New Wholesaler")
    assert page.has_content?('New Wholesaler')
    within "#new_wholesaler" do
      @labels.each do |f|
        assert has_field?(f)
      end
      assert has_field?('Terms')
    end
  end

  should "validate wholesaler and parts" do
    visit spree.new_admin_wholesaler_path
    click_button "Create"
    assert page.has_content?(I18n.t('spree.admin.wholesaler.failed'))
  end

  should "be a valid wholesaler but invalid parts" do
    visit spree.new_admin_wholesaler_path
    @labels.each_with_index do |label, index|
    	fill_in label, :with => @values[index]
    end
    select 'Credit Card', :from => 'Terms'
    click_button "Create"
    assert page.has_content?(I18n.t('spree.admin.wholesaler.failed'))
  end

  should "create wholesaler and parts" do
    visit spree.new_admin_wholesaler_path

    within ".wholesaler-details" do
      @labels.each_with_index do |label, index|
      	fill_in label, :with => @values[index]
      end
      select 'Credit Card', :from => 'Terms'
    end

    within ".user-details" do
      fill_in "Email", :with => random_email
      fill_in "Password", :with => "password"
      fill_in "Password Confirmation", :with => "password"
    end

    within "#billing" do
      @address_labels.each_with_index do |label, index|
        fill_in label, :with => @address_values[index]
      end
      select 'California', :from => 'State'
      select 'United States', :from => 'Country'
    end

    within "#shipping" do
      check "Use Billing Address"
    end

    click_button "Create"
    assert page.has_content?(I18n.t('spree.admin.wholesaler.success'))
  end


  context "an existing wholesaler" do

    setup do
      @wholesaler = Factory.create(:wholesaler)
    end

    should "update wholesaler, user and addresses" do
      visit spree.edit_admin_wholesaler_path(@wholesaler)
      within ".wholesaler-details" do
        @labels.each_with_index do |label, index|
        	fill_in label, :with => @values[index].reverse
        end
        select 'Credit Card', :from => 'Terms'
      end
      within "#billing" do
        @address_labels.each_with_index do |label, index|
          fill_in label, :with => @address_values[index].reverse
        end
        select 'California', :from => 'State'
        select 'United States', :from => 'Country'
      end
      within "#shipping" do
        uncheck "Use Billing Address"
        @address_labels.each_with_index do |label, index|
          fill_in label.sub('Billing', 'Shipping'), :with => @address_values[index]
        end
        select 'California', :from => 'State'
        select 'United States', :from => 'Country'
      end
      click_button "Update"
      assert page.has_content?(I18n.t('spree.admin.wholesaler.update_success'))
      assert page.has_content?('ylliB notrelliB')
    end

  end

end
