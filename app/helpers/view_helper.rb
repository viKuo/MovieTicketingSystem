module ViewHelper
	def format_time(time)
		Time.zone = "Central Time (US & Canada)"
		time = Time.zone.parse(time.to_s)
		time.strftime("%I:%M%p")
	end
end