class BookingsController < ApplicationController
	def index
		puts current_user.id
		if current_user.assigned?
			@cab = current_user.cabs.last
		end
		@cab_type = BookCab::Application.config.CAB_TYPE["cabs"]
	end

	def show_cabs
		lat = params[:latitude]
		long = params[:longitude]
		type = params[:type].constantize
		@cab = type.get_a_cab(lat,long,current_user)
		debugger
		redirect_to :bookings
	end

	def cancel_cab
		debugger
		puts current_user.id
		cab = current_user.cabs.last
		cab.cancel_ride(params[:latitude],params[:longitude])
		redirect_to :bookings
	end

	def get_cab_location
		@lat_long = current_user.assigned_cab.get_location
		render :json => @lat_long
	end

	def update_user_location
		current_user.set_current_location(params[:latitude],params[:longitude])
	end
end
