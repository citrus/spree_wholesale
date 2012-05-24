Spree::Product.instance_eval do

  delegate_belongs_to :master, :wholesale_price if Spree::Variant.table_exists? && Spree::Variant.column_names.include?("wholesale_price")

  attr_accessible :wholesale_price
  
end

Spree::Product.class_eval do

  def is_wholesaleable?
    0 < master.wholesale_price
  end

end
