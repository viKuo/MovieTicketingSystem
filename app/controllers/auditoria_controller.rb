class AuditoriaController < ApplicationController

	def index
		@auditoria = Auditorium.all
	end

	def show
		@auditorium = Auditorium.find(params[:id])
	end
end