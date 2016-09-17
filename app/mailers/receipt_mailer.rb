class ReceiptMailer < ApplicationMailer
  default from: 'notifications@example.com'
 
  def receipt_email(ticket)
    @ticket = ticket
    mail(to: @ticket.customer, subject: 'Here\'s your receipt!')
  end
end