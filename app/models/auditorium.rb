class Auditorium < ApplicationRecord
	has_many :showtimes
	has_many :tickets, through: :showtimes
end
