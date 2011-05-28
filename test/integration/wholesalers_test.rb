require_relative '../test_helper'

class WholesalersTest < ActiveSupport::IntegrationCase
  
  def setup
    Factory.create(:state)
      
    @user = Factory.create(:user)
    login_as @user
    
    @labels = %(Company, Buyer contact, Manager contact, Phone, Fax, Resale number, Taxid, Web address, Notes).split(', ')
    @values = %(Some Company, Buyer contact, Manager contact, 555-555-5555, 555-555-5555 ext 1, 12345, 123-45-6789, example.com, Yippee!).split(', ')
    @address_labels = %(Billing First Name, Billing Last Name, Street Address, City, Zip, Phone).split(', ')
    @address_values = %(Billy, Billerton, 111 State St, Santa Barbara, 93101, 555-555-5555).split(', ')
  end
  
  should "have a link to new wholesaler" do
    visit wholesalers_path
    within "#content .right form" do
      assert has_field?("Email")
      assert has_field?("Password")
    end
    assert has_link?("Apply Now!")
    click_link "Apply Now!"
    assert_equal new_wholesaler_path, current_path
  end
    
  should "get new wholesaler" do
    visit new_wholesaler_path
    assert has_content?(I18n.t('wholesale_signup'))
    within "#new_wholesaler" do
      @labels.each do |f|
        assert has_field?(f)
      end
      assert has_field?('Terms')
    end
    assert has_button?(I18n.t('wholesale_apply'))
  end
  
  should "validate wholesaler and parts" do
    visit new_wholesaler_path
    click_button I18n.t('wholesale_apply')
    assert_flash(:errors, I18n.t('wholesaler.signup_failed'))
    assert_seen "6 errors prohibited this record from being saved:", :within => ".wholesaler-details .errorExplanation"    
    assert_seen I18n.t("wholesaler.parts_error_message"), :within => ".wholesaler-details .errorExplanation"
  end
  
  should "be a valid wholesaler but invalid parts" do
    visit new_wholesaler_path       
    @labels.each_with_index do |label, index|
    	fill_in label, :with => @values[index]      
    end
    select 'Credit Card', :from => 'Terms'
    click_button I18n.t('wholesale_apply')
    assert_flash(:errors, I18n.t('wholesaler.signup_failed'))
    assert_seen I18n.t("wholesaler.parts_error_message"), :within => ".wholesaler-details .errorExplanation"
  end
  
  should "create wholesaler and parts" do
    visit new_wholesaler_path
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
    click_button I18n.t('wholesale_apply')
    assert_flash(:notice, I18n.t('wholesaler.signup_success'))    
  end
 
end
