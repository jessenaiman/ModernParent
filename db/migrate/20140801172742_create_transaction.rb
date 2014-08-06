class CreateTransaction < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
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
      t.string :comapny_name
      t.string :user_ip
      t.string :origin_url
      t.string :target_url
      t.string :promo_code
      t.text :gateway_response
      t.integer :home_riding
      t.string :transaction_type
      t.string :comments
      t.boolean :complete
      t.string :references
      t.integer :sql_server_id
      t.boolean :success
      t.decimal5 :total
      t.decimal2 :total
      t.decimal5 :amount
      t.decimal2 :amount
      t.integer :riding_id
      t.string :return_code
      t.integer :membership_month
      t.integer :membership_day
      t.integer :membership_year
      t.datetime :membership_cut_off
      t.decimal5 :price
      t.decimal2 :price
      t.integer :term
      t.user :references
    end
  end
end
