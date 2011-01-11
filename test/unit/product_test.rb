class ProductTest < ActiveSupport::TestCase
  
  test "create product with wholesale price" do
    product = Product.new
    assert !product.save, "Product could not be saved."
  end
  
  test "product responds to wolesale price" do
    product = Product.includes(:master).first
    if product  
      assert product.master.respond_to?(:wholesale_price), "Product is not wholesale ready. Try running `rake db:migrate` first."
    else
      assert false, "No test product found! Please create a product then run tests again"
    end
  end
    
  
end
