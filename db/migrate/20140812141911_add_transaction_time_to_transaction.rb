class AddTransactionTimeToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :transaction_time, :datetime
  end
end
