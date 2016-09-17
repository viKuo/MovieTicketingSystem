# MovieTicketingSystem

[Live demo here](https://movie-ticketing-system.herokuapp.com/)

[Live demo admin 'backend' here](https://movie-ticketing-system.herokuapp.com/admin)

##Schema
[relational database design](https://github.com/viKuo/MovieTicketingSystem/blob/master/Schema-design.png)
Originally I had another customer table that saved the email of the customer and the foreign key of ticket. However, I realized that since users are not required to log in and I was not saving credit card information, that table is not necessary. The customer field of the database should be an email.

## Validations
Validations are all done on the model, making sure that emails have the correct format, integer fields only have integers in the and so on. Showtimes has a custom validation that makes sure the starting time and ending time of movies do not overlap. ie Movie 1 starting at 1pm that lasts 2 hours will not allow for Movie 2 to start/end/show during the two hours Movie 1 will take up.

Credit card sanitation is done in the ticket controller. I am not sure how a processor would be implemented, and since I did not want to save credit card information on my database (due to safety practices), I had to implement it there.

## Virtual Attributes
While thinking about implementing validation for showtimes (not a virtual attribute, but still a method in the model) and tickets left, I considered which model would be the most appropriate. It could be argued that the auditorium should make sure showtimes don't over lap vs the showtime model. It could also be argued that the auditorium should be the one that knows how many tickets left to sell because it has the # of seats. I ultimately decided to place these methods in showtime because showtime has access to both audtiorium seats and movie name/duration, which are critical pieces of information for the two methods. This was a design choice I made so that the methods are (slighly) more readable, but I think these methods would make sense in the auditorium model as well.

## Styling and layout
Because one of the requirements for the project was mobile view, I went with [Material Design Lite](https://getmdl.io/index.html) for the framework. It is designed with Google's Material Design in mind and is straightforward to use.

## Emailing feature
Knowing that whatever emailing feature I chose had to be compatible with Heroku servers, a quick google search brought me to SendGrid. I used Rail's SMTP implementation and used SendGrid as the backend. This was new territory and it took me a while to figure out what I was doing.

At first I started to try to use the basic sendmail as described in the ActionMailer guide. However, I reaized that I would have to install sendmail on my machine and Heroku may or may not have it installed. I then had to ditch that idea and went with SMTP which is well documented online.

The last piece of puzzle for me was secrets.yml and environment variables, protecting my API keys. While this was an issue in our final project, I was not the one that implemented hiding it, so I actually didn't know how it was done. I did know how to use it however, by using ENV['APIKEY'] and the like. Fortunately Heroku had config variables on the dashboard so I was able to set them there. On my local machine, I finally figured out that I had to use the dotenv gem in order to do the same thing. 

## Testing
While I am confident in all of my work, testing is where I fell short. I used unit testing to test associations, a custom validaion, and a virtual attribute method.

I had the intention to test, but I wanted to complete this challenge in a timely manner. I also felt like feature testing wasn't crucial because I was the only one contributing to this project. I always iteratively tested while developing, kept my files small by using partials, and only introduced styling at the very end. I did not run into any major bugs during development. My only major setback was trying to implement mailing because that was new for me. So while I did not feature test, I am very confident that the app works as intended without it.

## Shiny fancy code
Overall, the website is a basic CRUD app. The only thing really shiny about it is the emailing function and my validation for showtimes. (even then its not that fancy really...)

```Ruby
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
```


[Showtime Validation Visual](https://github.com/viKuo/MovieTicketingSystem/blob/master/Showtime-overlap-validation-example.png)

The idea behind this code is that I want to find, as the visual above shows, either 1) the start time of the new showtime is between the showing of another movie, or 2) the end time of the new showtime is between the showing of another movie. Either one of these will cause overlap. If neither is true, then showtime is valid. The showtime/duration is calculated via movie length when entered into the system in munutes.

## Minor bugs
I am not sure what the deal with the timezones are. The showtimes are not in chronological order because the defalt is UTC time, so 6pm is 12am and that comes before all the other times. However, since I change the format of it to CST, 6pm comes before everything. In the email you can also see how the time is saved (which is incorrectly). I am not sure how to solve this issue.

## Conclusion
Thank you for taking the time to read my long spiel, checkout my demo and my code. Please let me know if you have any other questions.