class CreateTransaction < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.timestamps
      t.string :prefix
      t.string :first_name
      t.string :last_name
      t.string :street_address
      t.string :postal_code
      t.string :city
      t.string :telephone
      t.string :email
      t.string :card_name
      t.string :card_security
      t.string :card_expiry
      t.string :card_reference
      t.string :card_type
      t.string :personal
      t.string :company_name
      t.string :user_ip
      t.string :origin_url
      t.string :target_url
      t.string :promo_code
      t.text :gateway_response
      t.integer :home_riding
      t.string :transaction_type
      t.string :comments
      t.boolean :complete
      t.string :reference_id
      t.decimal :total
      t.decimal :amount
      t.decimal :amount
      t.integer :riding_id
      t.string :return_code
      t.datetime :membership_cut_off
      t.decimal :price
      t.integer :term 
    end
  end
end
