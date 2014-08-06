class Transaction < ActiveRecord::Base
  
  scope :memberships, -> { where(Type: 'Membership', ) }
  scope :donations, -> { where(Type: 'Donation') }
  scope :events, -> { where(Type: 'Item') }
  scope :abcs, -> { where(Type: 'ABC') }
  scope :under_amount, -> (amount) { lte(get_total: amount) }
  scope :over_amount, -> (amount) { gt(get_total: amount) }
  scope :total_sum_by_email, ->(email) { where(email: email).sum(:total) }
  scope :unsolicited, -> { where(TargetUrl: nil) }
  
  #scope :past, -> (type, timeframe) { where(Type: type, :transaction_time.gte => (Date.today - timeframe)) }#.order_by(:transaction_time.desc) }
  scope :by_ridings, -> (riding_id) { where(RidingId: riding_id) }
  
  def set_total
    unless self.GatewayResponse.nil?
      dollars = Hash.from_xml(self.GatewayResponse)["Result"]["FullTotal"].to_f * 100
      self.total = dollars #Money.new(dollars, "CAD")
    end
  end
  
  
end
