require 'rails_helper'

describe Movie do	
	let(:movie) { Movie.create!(name:"The Conjuring", duration: "120") }
	let(:auditorium) { Auditorium.create!(name: "Wean", seating: 120) }

	describe "Associations for movies" do
		it "has many showtimes" do
			movie.showtimes.create!(auditorium_id: auditorium.id, time: "13:00:00 CST")
			movie.showtimes.create!(auditorium_id: auditorium.id, time: "18:00:00 CST")
			expect(movie.showtimes.length).to be >0
		end

		it "has many tickets" do
			movie.showtimes.create!(auditorium_id: auditorium.id, time: "13:00:00 CST")
			movie.showtimes.create!(auditorium_id: auditorium.id, time: "18:00:00 CST")
			4.times do
				movie.showtimes[0].tickets.create!(customer:"v@g.com")
			end
			4.times do
				movie.showtimes[1].tickets.create!(customer:"v@g.com")
			end
			expect(movie.tickets.length).to be >0
		end
	end
end