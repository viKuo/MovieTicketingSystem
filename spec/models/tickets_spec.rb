require 'rails_helper'

describe Ticket do
	let(:movie) { Movie.create!(name:"The Conjuring", duration: "120") }
	let(:auditorium) { Auditorium.create!(name: "Wean", seating: 120) }
	let(:showtime) { movie.showtimes.create!(auditorium_id: auditorium.id, time: "13:00:00 CST")}
	let(:customer) { Customer.create!(email:"v@g.com") }

	describe "Associations for tickets" do
		it "belongs to a customer" do
			ticket = Ticket.create!( customer_id: customer.id, showtime_id: showtime.id)
			expect(ticket.customer).to eq customer
		end

		it "belongs to a showtime" do
			ticket = Ticket.create!( customer_id: customer.id, showtime_id: showtime.id)
			expect(ticket.showtime).to eq showtime
		end
	end
end