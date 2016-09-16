class TicketsController < ApplicationController
	def create
		if !credit_card_params.length == 16
			flash[:error] = "Credit card number invalid"
			redirect_to :back
		else
			Ticket.create!(ticket_params)		
			flash[:notice] = "You have bought a ticket. Please check your inbox for a receipt."
			redirect_to root_path
		end
	end

	private
  def ticket_params
    params.require(:ticket).permit(:showtime_id, :customer)
	end

	def credit_card_params
		params.require(:credit_card_number)
	end
end