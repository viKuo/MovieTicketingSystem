class ShowtimesController < ApplicationController

	def create
		Showtime.create!(showtime_params)
		redirect_to auditorium_url(showtime_params[:auditorium_id])
	end

	def destroy
		showtime = Showtime.find(params[:id])
		showtime.destroy
		redirect_to :back
	end

	private
  def showtime_params
    params.require(:showtime).permit(:movie_id, :auditorium_id, :time)
	end
end