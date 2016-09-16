class AdminController < ApplicationController
	def index
		@auditoria = Auditorium.all
		@tickets = Tickets.all
	end

end