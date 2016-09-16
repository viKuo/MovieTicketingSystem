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

	describe "Validtations for showtimes" do
		it "cannot start before a movie ends" do
			Showtime.create!(movie_id:movie.id, auditorium_id: auditorium.id, time: "13:00:00 CST")
			showtime = Showtime.create(movie_id:movie.id, auditorium_id: auditorium.id, time:"14:00:00 CST")
			showtime.valid?
			expect(showtime.errors.full_messages).to eq(["Showtime cannot start before another movie ends"])
		end

		it "cannot end after a movie starts" do
			Showtime.create!(movie_id:movie.id, auditorium_id: auditorium.id, time: "13:00:00 CST")
			showtime = Showtime.create(movie_id:movie.id, auditorium_id: auditorium.id, time:"12:00:00 CST")
			showtime.valid?
			expect(showtime.errors.full_messages).to eq(["Showtime cannot end after another movie starts"])
		end

		it "should know how many tickets left per showtime" do
			showtime = Showtime.create(movie_id:movie.id, auditorium_id: auditorium.id, time:"12:00:00 CST")
			customer = Customer.create!(email:"v@g.com")
			25.times do 
				showtime.tickets.create!(customer_id: customer.id)
			end
			seats_left = auditorium.seating - showtime.tickets.length
			expect(showtime.tickets_left).to eq(seats_left)
		end
	end
	
end