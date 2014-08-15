class AddEventsToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :description, :string
    add_column :transactions, :quantity, :integer
  end
end
