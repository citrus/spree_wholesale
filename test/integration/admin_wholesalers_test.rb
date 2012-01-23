require_relative '../test_helper'

class AdminWholesalersTest < ActiveSupport::IntegrationCase
  
  def setup
    Factory.create(:state)
      
    @user = Factory.create(:admin_user)
    login_as @user
    
    @labels = %(Company, Buyer contact, Manager contact, Phone, Fax, Resale number, Taxid, Web address, Notes).split(', ')
    @values = %(Some Company, Buyer contact, Manager contact, 555-555-5555, 555-555-5555 ext 1, 12345, 123-45-6789, example.com, Yippee!).split(', ')
    @address_labels = %(Billing First Name, Billing Last Name, Street Address, City, Zip, Phone).split(', ')
    @address_values = %(Billy, Billerton, 111 State St, Santa Barbara, 93101, 555-555-5555).split(', ')
  end
  
  should "have a link to new wholesaler" do
    visit admin_wholesalers_path
    btn = find(".actions a.button").native
    assert_match /#{new_admin_wholesaler_path}$/, btn.attribute('href')
    assert_equal "New Wholesaler", btn.text
  end
  
  should "get new wholesaler" do
    visit new_admin_wholesaler_path
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
    visit new_admin_wholesaler_path
    click_button "Create"
    # assert_flash(:error, I18n.t('admin.wholesalers.failed'))
#    save_and_open_page
    assert page.has_content?(I18n.t('wholesaler.signup_failed'))
    # assert_seen I18n.t("wholesaler.parts_error_message"), :within => ".errorExplanation"
    assert page.has_content?(I18n.t('wholesaler.parts_error_message'))
  end
  
  should "be a valid wholesaler but invalid parts" do
    visit new_admin_wholesaler_path       
    @labels.each_with_index do |label, index|
    	fill_in label, :with => @values[index]      
    end
    select 'Credit Card', :from => 'Terms'
    click_button "Create"
    # assert_flash(:error, I18n.t('admin.wholesalers.failed'))
    assert page.has_content?(I18n.t('wholesaler.signup_failed'))
    # assert_seen I18n.t("wholesaler.parts_error_message"), :within => ".errorExplanation"
    assert page.has_content?(I18n.t('wholesaler.parts_error_message'))
  end
  
  should "create wholesaler and parts" do
    visit new_admin_wholesaler_path       
    
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
  
    within ".billing-details" do
      @address_labels.each_with_index do |label, index|
        fill_in label, :with => @address_values[index]
      end
      select 'California', :from => 'State'
      select 'United States', :from => 'Country'
      check "Use billing address for shipping"
    end
    
    
    click_button "Create"
    # assert_flash(:notice, I18n.t('admin.wholesalers.success'))    
    assert page.has_content?(I18n.t('admin.wholesalers.success'))
  end
  
  
  context "an existing wholesaler" do
    
    setup do
      @wholesaler = Factory.create(:wholesaler)
    end
    
    should "update wholesaler, user and addresses" do
      visit edit_admin_wholesaler_path(@wholesaler)
      within ".wholesaler-details" do
        @labels.each_with_index do |label, index|
        	fill_in label, :with => @values[index].reverse      
        end
        select 'Credit Card', :from => 'Terms'
      end
      within ".billing-details" do
        @address_labels.each_with_index do |label, index|
          fill_in label, :with => @address_values[index].reverse
        end
        select 'California', :from => 'State'
        select 'United States', :from => 'Country'
        uncheck "Use billing address for shipping"
      end
      within ".shipping-details" do
        @address_labels.each_with_index do |label, index|
          fill_in label.sub('Billing', 'Shipping'), :with => @address_values[index]
        end
        select 'California', :from => 'State'
        select 'United States', :from => 'Country'
      end
      click_button "Update"
      # assert_flash(:notice, "Successfully updated!")
      assert page.has_content?('Successfully updated!')
      # assert_seen "ylliB notrelliB", :within => ".rightie .adr:first"
      assert page.has_content?('ylliB notrelliB')
    end
    
    
    # no worky without JS :( 
    
    #should "update switch to a foreign address" do
    #  visit edit_admin_wholesaler_path(@wholesaler)
    #  
    #  sleep 3
    #  
    #  within ".billing-details" do
    #    uncheck "Use billing address for shipping"
    #  end
    #  
    #  sleep 3
    #  
    #  within ".shipping-details" do
    #    select 'Switzerland', :from => 'Country'
    #    
    #    sleep 5
    #    
    #    
    #  end
    #  
    #  
    #end 
    
    
  end
  
end