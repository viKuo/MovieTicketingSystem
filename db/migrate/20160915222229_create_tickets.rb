class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.integer :showtime_id
      t.string :customer
      
      t.timestamps
    end
  end
end
