Variant.class_eval do 
  
  def is_wholesaleable?
    0 < wholesale_price
  end
  
end