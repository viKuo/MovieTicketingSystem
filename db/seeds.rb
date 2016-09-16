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

movies = Movie.create!([
	{ name: "Pirates of the Carribean", duration: 120 },
	{ name: "Whiplash", duration: 105 },
	{ name: "Spirited Away", duration: 125},
	{ name: "Interstellar", duration: 169},
	])

movies.each do |movie|
	movie.showtimes.create!({ time: "10:00:00 CDT", auditorium_id: movie.id})
	movie.showtimes.create!({ time: "13:00:00 CDT", auditorium_id: movie.id})
	movie.showtimes.create!({ time: "16:00:00 CDT", auditorium_id: movie.id})
	movie.showtimes.create!({ time: "19:00:00 CDT", auditorium_id: movie.id})
end

showtimes = Showtime.all

30.times do
	showtimes[rand(15)].tickets.create!(customer: Faker::Internet.email)
end