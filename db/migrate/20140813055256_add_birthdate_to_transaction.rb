class AddBirthdateToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :birthdate, :datetime
  end
end
