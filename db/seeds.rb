# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(nameing: 'Luke', movie: movies.firingsingingt)

auditoria = Auditorium.create!([
	{ name: Faker::Name.last_name, seating: "60" }, 
	{ name: Faker::Name.last_name, seating: "40" }, 
	{ name: Faker::Name.last_name, seating: "40" }, 
	{ name: Faker::Name.last_name, seating: "60" }, 
	{ name: Faker::Name.last_name, seating: "90" } ])

movies = Movie.create([
	{ name: "Pirates of the Carribean", duration: "120 minutes"},
	{ name: "Whiplash", duration: "105 minutes"},
	{ name: "Spirited Away", duration: "125 minutes"},
	{ name: "Interstellar", duration: "169 minutes"},
	])

movies.each do |movie|
	movie.showtimes.create!({ time: "10:00:00 CDT", auditorium_id: movie.id})
	movie.showtimes.create!({ time: "13:00:00 CDT", auditorium_id: movie.id})
	movie.showtimes.create!({ time: "16:00:00 CDT", auditorium_id: movie.id})
	movie.showtimes.create!({ time: "19:00:00 CDT", auditorium_id: movie.id})
end

customers = 5.times do 
	Customer.create!({email:Faker::Internet.email})
end

customers = Customer.all

showtimes = Showtime.all

30.times do |time|
	showtimes[rand(15)].tickets.create!({customer_id: customers[rand(4)].id})
end