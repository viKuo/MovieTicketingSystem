class TicketsController < ApplicationController

	def index
		@movies = Movie.all
	end

end