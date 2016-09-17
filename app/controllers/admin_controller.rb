class AdminController < ApplicationController
	def index
		@auditoria = Auditorium.all
		@movies = Movie.all
		@tickets = Ticket.order(:showtime_id)
	end

end