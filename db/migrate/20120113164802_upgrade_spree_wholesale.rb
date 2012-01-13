class UpgradeSpreeWholesale < ActiveRecord::Migration
  
  def self.up
    remove_column :wholesalers, :created_at
    remove_column :wholesalers, :updated_at
    add_column :wholesalers, :created_at, :datetime
    add_column :wholesalers, :updated_at, :datetime
    Wholesaler.all.each do |wholesaler|
      wholesaler.created_at = wholesaler.user.created_at
      wholesaler.save
    end    
  end

  def self.down
    remove_column :wholesalers, :created_at
    remove_column :wholesalers, :updated_at
  end

end