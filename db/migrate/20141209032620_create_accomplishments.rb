class CreateAccomplishments < ActiveRecord::Migration
  def change
    create_table :accomplishments do |t|
      t.text :notes

      t.timestamps
    end
  end
end
