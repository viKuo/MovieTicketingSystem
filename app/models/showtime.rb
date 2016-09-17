class Showtime < ApplicationRecord
	validate :showtimes_cannot_overlap
	validates :auditorium_id, :movie_id, presence: true
	 
	belongs_to :movie
	belongs_to :auditorium
	has_many :tickets

	def showtimes_cannot_overlap
		showtimes_in_same_aud = Showtime.where(auditorium_id: self.auditorium.id)
		movie_duration = Movie.find(self.movie.id).duration
		movie_start = self.time.to_i
		movie_end = (self.time + movie_duration*60).to_i
		showtimes_in_same_aud.each do |showtime|
			other_movie_showtime = showtime.time.to_i
			other_movie_endtime = (showtime.time + showtime.movie.duration*60).to_i
			if (other_movie_showtime < movie_start && movie_start < other_movie_endtime)
				errors.add(:showtime, "cannot start before another movie ends")
				return false
			elsif (other_movie_showtime < movie_end && movie_end < other_movie_endtime)
				errors.add(:showtime, "cannot end after another movie starts")
				return false
			end
		end
		true
	end

	def tickets_left
		self.auditorium.seating - self.tickets.length
	end
end
