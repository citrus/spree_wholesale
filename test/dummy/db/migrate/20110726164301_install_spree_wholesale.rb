class InstallSpreeWholesale < ActiveRecord::Migration
  
  def self.up
  
    create_table :wholesalers do |t|
      t.references :user
      t.integer :billing_address_id
      t.integer :shipping_address_id
      t.string :company
      t.string :buyer_contact
      t.string :manager_contact
      t.string :phone
      t.string :fax
      t.string :resale_number
      t.string :taxid
      t.string :web_address
      t.string :terms
      t.string :alternate_email
      t.text   :notes
      t.timestamps
    end
  
    add_index :wholesalers, [:billing_address_id, :shipping_address_id]
  
    add_column :orders,   :wholesale,       :boolean, :default   => false
    add_column :variants, :wholesale_price, :decimal, :precision => 8, :scale => 2, :null => false, :default => 0

  end

  def self.down
    remove_column :variants, :wholesale_price
    remove_column :orders,   :wholesale

    drop_table :wholesalers
  end

end