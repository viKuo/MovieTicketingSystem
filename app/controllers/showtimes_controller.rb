class ShowtimesController < ApplicationController

	def index
	end

	def create
		Showtime.create!(showtime_params)
		redirect_to auditorium_url(showtime_params[:auditorium_id])
	end

	private
  def showtime_params
    params.require(:showtime).permit(:movie_id, :auditorium_id, :time)
	end
end