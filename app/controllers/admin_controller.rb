class AdminController < ApplicationController
	def index
		@auditoria = Auditorium.all
		@movies = Movie.all
		@tickets = Ticket.all
	end

end