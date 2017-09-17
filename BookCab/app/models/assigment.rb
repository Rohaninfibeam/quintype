class Assigment < ApplicationRecord
	belongs_to :user
	belongs_to :cab

	def set_source_location(latitude, longitude)
		latitude = latitude.to_f
		longitude = longitude.to_f
		self.source_lat = latitude
		self.source_long = longitude
		self.save!
	end

	def set_dest_location(latitude,longitude)
		latitude = latitude.to_f
		longitude = longitude.to_f
		self.dest_lat = latitude
		self.dest_long = longitude
		self.save!
	end

	def get_source_location
		[self.source_lat,self.source_long]
	end

	def get_dest_location
		[self.dest_lat,self.dest_long]
	end

	def start_ride(latitude,longitude)
		set_source_location(latitude,longitude)
		self.start_time = Time.now
		self.save!
	end

	def end_ride(latitude,longitude)
		set_dest_location(latitude,longitude)
		self.end_time = Time.now
		self.distance = find_distance.present? ? find_distance : nil
		self.price = find_total_price.present? ? find_total_price : nil
		self.save!
	end

	def cancel_ride
		self.cancelled_time = Time.now
		self.save!
	end

	private

	def find_distance
		if self.end_time.present?
			total_distance(get_dest_location,get_source_location)
		else
			nil
		end
	end

	def find_total_price
		if self.distance.present? && self.start_time.present? && self.end_time.present?
			total_time = (self.end_time- self.start_time)/60
			total_time*1 + distance*2
		else
			nil
		end
	end
end
