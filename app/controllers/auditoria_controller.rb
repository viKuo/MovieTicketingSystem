class AuditoriaController < ApplicationController

	def index
		@auditoria = Auditorium.all
	end

	def show
		@auditorium = Auditorium.find(params[:id])
	end

	def new
		@auditorium = Auditorium.new
	end

	def create
		auditorium = Auditorium.new(auditorium_params)
		if auditorium.valid?
			auditorium.save
			redirect_to admin_index_url
		else
			flash[:error] = auditorium.errors.full_messages
			redirect_to :back
		end
	end

		private
  def auditorium_params
    params.require(:auditorium).permit(:name, :seating)
	end
end