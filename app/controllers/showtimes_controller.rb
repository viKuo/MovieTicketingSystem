class ShowtimesController < ApplicationController

	def create
		showtime = Showtime.new(showtime_params)
		if showtime.valid?
			showtime.save
		else
			flash[:error] = showtime.errors.full_messages[0]
		end
		redirect_to auditorium_url(showtime_params[:auditorium_id])
	end

	def destroy
		showtime = Showtime.find(params[:id])
		showtime.destroy
		redirect_to :back
	end

	def show
		@showtime = Showtime.find(params[:id])
	end

	private
  def showtime_params
    params.require(:showtime).permit(:movie_id, :auditorium_id, :time)
	end
end