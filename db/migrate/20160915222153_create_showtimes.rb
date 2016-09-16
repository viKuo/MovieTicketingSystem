class CreateShowtimes < ActiveRecord::Migration[5.0]
  def change
    create_table :showtimes do |t|
      t.time :time
      t.integer :auditorium_id
      t.integer :movie_id

      t.timestamps
    end
  end
end
                                                 