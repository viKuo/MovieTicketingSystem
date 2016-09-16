class Movie < ApplicationRecord
	validates :name, :duration, presence: true
	validates :duration, numericality: {greater_than: 0, only_integer: true}
	has_many :showtimes
	has_many :tickets, through: :showtimes
end
