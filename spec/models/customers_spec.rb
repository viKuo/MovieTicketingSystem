require 'rails_helper'

describe Customer do
	let(:movie) { Movie.create!(name:"The Conjuring", duration: "120") }
	let(:auditorium) { Auditorium.create!(name: "Wean", seating: 120) }
	let(:showtime) { movie.showtimes.create!(auditorium_id: auditorium.id, time: "13:00:00 CST")}
	let(:customer) { Customer.create!(email:"v@g.com") }

	describe "Associations for customers" do
		it "has many tickets" do
			showtime.tickets.create!(customer_id: customer.id)
			showtime.tickets.create!(customer_id: customer.id)
			showtime.tickets.create!(customer_id: customer.id)
			expect(customer.tickets.length).to be >0
		end
	end

end