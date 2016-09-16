class Ticket < ApplicationRecord
	validates :showtime_id, :customer_id, presence: true
	belongs_to :showtime
	belongs_to :customer
end
