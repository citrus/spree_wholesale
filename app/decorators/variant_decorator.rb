Variant.class_eval do 
  scope :wholesales, where("variants.wholesale_price > 0")
  
  def is_wholesaleable?
    0 < wholesale_price
  end
  
end