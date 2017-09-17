class DriversController < ApplicationController
	before_action :authenticate_driver!

	def index
		@cab = Driver.find(current_driver["id"]).cab
		@user = @cab.current_cab_user
		debugger
	end

	def update_location
		current_driver.cab.set_location(params[:latitude],params[:longitude])
	end

	def get_user_location
		user = current_driver.cab.current_cab_user
		@location = user.get_location
		render :json => @location
	end

	def start_ride
		current_driver.cab.start_ride(params[:latitude],params[:longitude])
		redirect_to :drivers
	end

	def end_ride
		current_driver.cab.end_ride(params[:latitude],params[:longitude])
		redirect_to :drivers
	end
end
