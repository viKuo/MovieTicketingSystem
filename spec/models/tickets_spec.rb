require 'rails_helper'

describe Ticket do
	let(:movie) { Movie.create!(name:"The Conjuring", duration: "120") }
	let(:auditorium) { Auditorium.create!(name: "Wean", seating: 120) }
	let(:showtime) { movie.showtimes.create!(auditorium_id: auditorium.id, time: "13:00:00 CST")}

	describe "Associations for tickets" do

		it "belongs to a showtime" do
			ticket = Ticket.create!( customer: "v@g.com", showtime_id: showtime.id)
			expect(ticket.showtime).to eq showtime
		end
	end
end