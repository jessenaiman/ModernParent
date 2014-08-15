class Transaction < ActiveRecord::Base
  
  scope :memberships, -> { where(transaction_type: 'Membership', ) }
  scope :donations, -> { where(transaction_type: 'Donation') }
  scope :events, -> { where(transaction_type: 'Item').no_promo_codes }
  scope :abcs, -> { where(transaction_type: 'ABC') }
  scope :under_amount, -> (amount) { where("total < ?", amount) }
  scope :over_amount, -> (amount) { where("total > ?", amount) }
  scope :total_sum_by_email, ->(email) { where(email: email).sum(:total) }
  scope :unsolicited, -> { where(target_url: nil) }
  scope :no_promo_codes, -> { where(promo_code: nil) }
  scope :promo_codes, -> { where.not(promo_code: "") }
  
  scope :past, -> (transaction_type, timeframe) { where(transaction_type: transaction_type).where("transaction_time > ?", (Date.today - timeframe) ) }
  scope :by_ridings, -> (riding_id) { where(riding_id: riding_id) }
  
  before_create :set_total
  before_create :set_transaction_time
  before_create :set_promo_code
  
  def get_total
    if self.gateway_response.nil?
      0
    else
      Hash.from_xml(self.gateway_response)["Result"]["FullTotal"].to_i
    end
  end

  def set_total
    if self.total.nil?
      self.total = get_total
      #self.save
    end
  end
  
  def set_transaction_time
    if self.transaction_time.nil? && !self.gateway_response.nil?
      trans_time = !self.gateway_response.nil? ? Hash.from_xml(self.gateway_response)["Result"]["TransTime"] : nil?
      stamp = DateTime.strptime(trans_time, "%a %b %d %k:%M:%S %Z %Y")
      if self.transaction_time != stamp || stamp.nil?
        self.transaction_time = stamp
      elsif self.transaction_type == "ABC"
        self.transaction_time = Date.new(2000, 1, 1)
      end
      self.created_at = self.transaction_time
    end
  end
  
  def set_promo_code
    no_whitespace_target_url = self.target_url.gsub(/\s+/, "")
    promo_code = Rack::Utils.parse_query URI(no_whitespace_target_url).query
    self.promo_code = promo_code["promo-code"]
  end
    
  def get_birthday
    if self.transaction_type == "Membership"
      Date.new(self.Year, self.Month, self.Day)
    end
  end
  
end
