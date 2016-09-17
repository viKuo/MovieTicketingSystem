class TicketsController < ApplicationController
	def create
		ticket = Ticket.new(ticket_params)
		if !credit_card_params.length == 16 || credit_card_params.match(/\D/)
			flash[:error] = ["Credit card number invalid"]
			redirect_to :back
		elsif !ticket.valid?
			flash[:error] = ticket.errors.full_messages
			redirect_to :back
		elsif ticket.showtime.tickets_left <= 0
			flash[:notice] = "Sorry, there are no more seats left for this showing! Please choose another movie"
			redirect_to root_path
		else
			ticket.save
			flash[:notice] = "You have bought a ticket. Please check your inbox for a receipt."
			ReceiptMailer.receipt_email(ticket).deliver_now
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