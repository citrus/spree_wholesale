class AddWholesaleToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :wholesale, :boolean, :default => false
  end

  def self.down
    remove_column :orders, :wholesale
  end
end