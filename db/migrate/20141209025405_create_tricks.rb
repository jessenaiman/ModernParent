class CreateTricks < ActiveRecord::Migration
  def change
    create_table :tricks do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
