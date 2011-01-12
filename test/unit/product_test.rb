class ProductTest < ActiveSupport::TestCase

  
  test "product responds to wolesale price" do
    product = products(:wholesale)
    assert product.master.respond_to?(:wholesale_price), "Product is not wholesale ready. Try running `rake db:migrate` first."
  end
  
  test "product is wholesaleble" do
    product = products(:wholesale)
    assert product.is_wholesaleable?
  end
    
    
end
