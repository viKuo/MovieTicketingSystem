require 'rails_helper'

describe Showtime do
	let(:movie) { Movie.create!(name:"The Conjuring", duration: "120") }
	let(:auditorium) { Auditorium.create!(name: "Wean", seating: 120) }

	describe "Associations for showtimes" do
		it "belongs to a movie" do
			showtime = Showtime.create!(movie_id: movie.id, auditorium_id: auditorium.id, time: "13:00:00 CST")
			expect(showtime.movie).to eq movie
		end

		it "belongs to an auditorium" do
			showtime = Showtime.create!(movie_id: movie.id, auditorium_id: auditorium.id, time: "13:00:00 CST")
			expect(showtime.auditorium).to eq auditorium
		end

		it "has many tickets" do
			showtime = Showtime.create!(movie_id: movie.id, auditorium_id: auditorium.id, time: "13:00:00 CST")
			customer = Customer.create!(email:"v@g.com")

			5.times do 
				showtime.tickets.create!(customer_id:customer.id)
			end

			expect(showtime.tickets.length).to be >0
		end
	end
	
end