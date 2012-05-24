require 'test_helper'

class Spree::WholesalersTest < ActiveSupport::IntegrationCase

  def setup
    Factory.create(:state)

    @user = Factory.create(:user)
    login_as @user

    @labels = %(Company, Buyer contact, Manager contact, Phone, Fax, Resale number, Taxid, Web address, Notes).split(', ')
    @values = %(Some Company, Buyer contact, Manager contact, 555-555-5555, 555-555-5555 ext 1, 12345, 123-45-6789, example.com, Yippee!).split(', ')
    @address_labels = %(First Name, Last Name, Street Address, City, Zip, Phone).split(', ')
    @address_values = %(Billy, Billerton, 111 State St, Santa Barbara, 93101, 555-555-5555).split(', ')
  end

  should "have a link to new wholesaler" do
    visit spree.wholesalers_path
    within ".login" do
      assert page.has_field?("Email")
      assert page.has_field?("Password")
    end
    assert page.has_link?("Apply Now!")
    click_link "Apply Now!"
    assert_equal spree.new_wholesaler_path, current_path
  end

  should "get new wholesaler" do
    visit spree.new_wholesaler_path
    assert page.has_content?(I18n.t('wholesale_signup'))
    within "#new_wholesaler" do
      @labels.each do |f|
        assert page.has_field?(f)
      end
      assert page.has_field?('Terms')
    end
    assert has_button?(I18n.t('wholesale_apply'))
  end

  should "validate wholesaler and parts" do
    visit spree.new_wholesaler_path
    click_button I18n.t('wholesale_apply')

    assert page.has_content?(I18n.t('spree.wholesaler.signup_failed'))
    assert page.has_content?('21 errors prohibited this record from being saved:')
  end

  should "be a valid wholesaler but invalid parts" do
    visit spree.new_wholesaler_path
    @labels.each_with_index do |label, index|
    	fill_in label, :with => @values[index]
    end
    select 'Credit Card', :from => 'Terms'
    click_button I18n.t('wholesale_apply')
    assert page.has_content?(I18n.t('spree.wholesaler.signup_failed'))
  end

  should "create wholesaler and parts" do
    visit spree.new_wholesaler_path
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

    click_button I18n.t('wholesale_apply')
    assert page.has_content?(I18n.t('spree.wholesaler.signup_success'))
  end

end
