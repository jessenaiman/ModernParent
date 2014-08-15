class Api::V1::TransactionsController < Api::V1::BaseController
  doorkeeper_for :all
  respond_to :json
  
   # POST /transactions.json
  def create
    
    @transaction = Transaction.create!(transactions_params)

    success   = @transaction.save
    respond_to do |format|
      if success
        format.json { render json: 'document saved to mongodb', status: :created }
      else
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def transactions_params
      params.require(:transaction).permit(
          :prefix, 
          :first_name, 
          :last_name, 
          :street_address, 
          :postal_code, 
          :city, 
          :telephone, 
          :email, 
          :card_name, 
          :card_security, 
          :card_expiry,
          :card_reference, 
          :card_type, 
          :personal,
          :company_name, 
          :user_ip, 
          :origin_url, 
          :target_url,
          :gateway_response, 
          :home_riding,
          :transaction_type, 
          :comments, 
          :complete,
          :riding_id,
          :return_code, 
          #membership fields
          :birthdate,
          :membership_cut_off,
          :term,
          :total,
          :price,
          #event fields
          :amount,  
          :promo_code,    
          :description,
          :quantity,
          :reference,
          :transaction_time)
  end
  
end