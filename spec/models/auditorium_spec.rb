require 'rails_helper'

describe Auditorium do
	let(:movie) { Movie.create!(name:"The Conjuring", duration: "120") }
	let(:auditorium) { Auditorium.create!(name: "Wean", seating: 120) }

	describe "Associations for auditoria" do
		it "has many showtimes" do
			Showtime.create!(movie_id: movie.id, auditorium_id: auditorium.id, time: "13:00:00 CST")
			Showtime.create!(movie_id: movie.id, auditorium_id: auditorium.id, time: "18:00:00 CST")
			expect(auditorium.showtimes.length).to be >0
		end

		it "has many tickets" do
			showtime = Showtime.create!(movie_id: movie.id, auditorium_id: auditorium.id, time: "13:00:00 CST")
			3.times { showtime.tickets.create!(customer:"v@g.com") }
			expect(auditorium.tickets.length).to be >0
		end
	end

end