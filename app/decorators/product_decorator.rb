Product.instance_eval do 

  delegate_belongs_to :master, :wholesale_price if Variant.table_exists? && Variant.column_names.include?("wholesale_price")
  
end

Product.class_eval do  

  def is_wholesaleable?
    0 < master.wholesale_price
  end
  
end