class Auditorium < ApplicationRecord
	validates :name, :seating, presence: true
	validates :seating, numericality: {greater_than: 0, only_integer: true}  
	has_many :showtimes
	has_many :tickets, through: :showtimes
end
