Spree::Order.class_eval do

  def wholesale
    read_attribute(:wholesale) && !wholesaler.nil?
  end

  def wholesaler
    user && user.wholesaler
  end

  def is_wholesale?
    wholesale
  end

  def set_line_item_prices(use_price=:price)
    line_items.includes(:variant).each do |line_item|
      line_item.price = line_item.variant.send(use_price)
      line_item.save
    end
  end

  def to_fullsale!
    self.wholesale = false
    set_line_item_prices(:price)
    update!
    save
  end

  def to_wholesale!
    return false unless user.wholesaler.present?
    self.wholesale = true
    set_line_item_prices(:wholesale_price)
    update!
    save
  end

  def add_variant(variant, quantity = 1)
    current_item = contains?(variant)
    if current_item
      current_item.quantity += quantity
      current_item.save
    else
      current_item = Spree::LineItem.new(:quantity => quantity)
      current_item.variant = variant
      current_item.price   = is_wholesale? ? variant.wholesale_price : variant.price
      self.line_items << current_item
    end

    # populate line_items attributes for additional_fields entries
    # that have populate => [:line_item]
    # Spree::Variant.additional_fields.select{|f| !f[:populate].nil? && f[:populate].include?(:line_item) }.each do |field|
    #   value = ""

    #   if field[:only].nil? || field[:only].include?(:variant)
    #     value = variant.send(field[:name].gsub(" ", "_").downcase)
    #   elsif field[:only].include?(:product)
    #     value = variant.product.send(field[:name].gsub(" ", "_").downcase)
    #   end
    #   current_item.update_attribute(field[:name].gsub(" ", "_").downcase, value)
    # end

    current_item
  end

end
