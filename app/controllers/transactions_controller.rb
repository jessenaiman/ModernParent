class TransactionsController < ApplicationController
  before_filter :authenticate_user!, :set_riding
  helper_method :sort_column, :sort_direction, :sort_and_page

  def index
    
    if !params[:transaction_type].nil?
      @transactions = @transactions.where(transaction_type: params[:type])
    end
    
    #process search
    if params[:query]
      @transactions = Transaction.full_text_search(params[:query])#.page params[:page]
    end

    @riding_id = params[:riding_id]
    
    respond_to do |format|
      format.html { sort_and_page }
      #format.csv { send_data @transactions.to_csv }
      format.xls
      format.js { sort_and_page }
    end
  end
  
  def events
    @transactions = @transactions.where(transaction_type: 'Item')
    respond_to do |format|
      format.html { sort_and_page }
      format.xls
      format.js { sort_and_page }
    end
  end
  
  def donations
    @transactions = @transactions.where(transaction_type: 'Donation')
    respond_to do |format|
      format.html { sort_and_page }
      format.xls
      format.js { sort_and_page }
    end
  end
  
  def memberships
    @transactions = @transactions.where(transaction_type: 'Membership')
    respond_to do |format|
      format.html { sort_and_page }
      format.xls
      format.js { sort_and_page }
    end
  end
  
  def show
    set_transactions(params[:transactions][:start_date], params[:transactions][:end_date])
    #@transactions = @transactions.order_by(:transaction_time.desc).page(params[:page]).per(10)
    respond_to do |format|
      format.html { sort_and_page }
      format.xls
      format.js { sort_and_page }
    end
  end
  
  def metrics
    
  end
  
  def export_excel
    set_transactions(params[:start_date], params[:end_date])
    respond_to do |format|
      format.xls
    end
  end

  def search_date #(start_date, end_date)
     riding_id = params[:riding_id]
    #process the date filter
    @transactions = @transactions.where(transaction_time: Date.strptime(params[:transactions][:start_date], '%m/%d/%Y').beginning_of_day..Date.strptime(params[:transactions][:end_date], '%m/%d/%Y').beginning_of_day)
    
    respond_to do |format|
      format.js { sort_and_page }
      format.xls
      format.html { sort_and_page }
    end
  end
  
  def search
    @transactions = Transaction.search(params['query']).page(0).limit(20)
    
    response_to do |format|
      format.js
    end
  end

  def search_params
    params.each do |key, value|
      # target groups using regular expressions
      skip_list = %w(auth_token action controller format scope)
      unless skip_list.include?(key)
        @transactions = @transactions.where(key => value)
      end
    end
  end
  
  def set_transactions(start_date, end_date)
    riding_id = params[:riding_id]
    #process the date filter
    @transactions = Transaction.between(transaction_time: Date.strptime(start_date, '%m/%d/%Y')..Date.strptime(end_date, '%m/%d/%Y'))
    
    if !riding_id.nil?
      @transactions = @transactions.where(riding_id: current_user.riding_id)
    end
  end
  
  def set_metrics
    @memberships_count = Transaction.membership.count
    @donations_count = Transaction.donations.count
    @event_count = Transaction.events.count
    @abcs_count = Transaction.abcs.count
  end
  
  def set_riding
    @transactions = Transaction.all
    unless current_user.email == 'webadmin@ontarioliberal.ca'
      @transactions = @transactions.by_ridings current_user.riding_id
    end
  end
  
  private
  
  def sort_and_page
    @transactions = @transactions.order(sort_column + " " + sort_direction).page(params[:page]).per(10)
  end
  
  def sort_column
    Transaction.column_names.include?(params[:sort]) ? params[:sort] : "transaction_time"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
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
