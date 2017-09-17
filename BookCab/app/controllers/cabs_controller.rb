class CabsController < ApplicationController
	def index
		@cabs = Cab.all
	end 

	def new
		@cab = Cab.new
		@cab_type = BookCab::Application.config.CAB_TYPE["cabs"]
	end

	def create
		@cab = Cab.new(cab_params)
		if @cab.save
			redirect_to cabs_url
		else
			@cab_type = BookCab::Application.config.CAB_TYPE["cabs"]
			render :new
		end
	end

	def update_location
		@cab = Cab.find(params[:id])
		@cab.set_location(params[:latitude],params[:longitude])
		@cab.save
	end

	private

	def cab_params
		params.require(:cab).permit(:name,:current_latitude,:current_longitude,:type,:reg_number)
	end
end
