class ProductTest < ActiveSupport::TestCase

  
  test "product responds to wolesale price" do
    product = get_product
    assert product.master.respond_to?(:wholesale_price), "Product is not wholesale ready. Try running `rake db:migrate` first."
  end
  
  test "product is wholesaleble" do
    product = get_product
    product.wholesale_price = 10.00
    assert get_product.is_wholesaleable?
  end
    
    
end
