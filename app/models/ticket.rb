class Ticket < ApplicationRecord
	validates :showtime_id, :customer, presence: true
	validates :customer, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
	belongs_to :showtime#, -> { includes :movie }
end
