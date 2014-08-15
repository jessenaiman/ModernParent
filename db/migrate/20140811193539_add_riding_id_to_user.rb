class AddRidingIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :riding_id, :string
  end
end
