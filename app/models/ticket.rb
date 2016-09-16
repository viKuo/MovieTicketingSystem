class Ticket < ApplicationRecord
	validates :showtime_id, :customer, presence: true
	belongs_to :showtime
end
