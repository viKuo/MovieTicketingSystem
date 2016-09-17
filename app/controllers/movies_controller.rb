class MoviesController < ApplicationController
	def index
		@movies = Movie.all
	end

	def new
		@movie = Movie.new
	end

	def create
		movie = Movie.new(movie_params)
		if movie.valid?
			movie.save
			flash[:notice] = "#{movie.name} has been added"
			redirect_to admin_index_path
		else
			flash[:error] = movie.errors.full_messages
			redirect_to :back
		end
	end

	private
  def movie_params
    params.require(:movie).permit(:name, :duration)
	end
end