class AddWholesaleToVariants < ActiveRecord::Migration
  def self.up
    add_column :variants, :price, :decimal, :precision => 8, :scale => 2, :null => false
  end

  def self.down
    remove_column :variants, :price
  end
end