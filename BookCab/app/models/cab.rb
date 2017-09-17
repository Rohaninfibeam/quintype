class Cab < ApplicationRecord
	has_many :assigments
	has_many :users, :through => :assigments
	belongs_to :driver
	include AASM

	aasm do
		state :not_assigned, :initial => true
		state :assigned, :ride_started
		event :assign do
			transitions :from => :not_assigned, :to => :assigned
		end
		event :start_ride do
			transitions :from => :assigned, :to => :ride_started
		end
		event :end_ride do
			transitions :from => :ride_started, :to => :not_assigned
		end
		event :cancel_ride do
			transitions :from => :assigned, :to => :not_assigned
		end
	end

	def self.find_near_by_cabs(latitude, longitude)
		latitude = latitude.to_f
		longitude = longitude.to_f
		cabs = self.find_not_assigned_cabs.map do |m|
			[m.id,m.find_distance(latitude, longitude)]
		end
		if !cabs.blank?
			min = cabs.map(&:last).min
			cab_id = cabs.select{|a,b| b==min}[0]
			self.find(cab_id.first)
		else
			nil
		end
	end

	def self.get_a_cab(latitude,longitude,user)
		if user.not_assigned?
			latitude = latitude.to_f
			longitude = longitude.to_f
			cab = find_near_by_cabs(latitude,longitude)
			if !cab.blank?
				cab.with_lock do
					if cab.not_assigned?
						cab.cab_assign(user)
					else
						self.get_a_cab(latitude,longitude,user) and return
					end
				end
			else
				nil
			end
		else
			user.assigments.last.cab
		end
	end

	def self.find_not_assigned_cabs
		self.all.select{|c| !c.assigned?}
	end

	def cab_assign(user)
		if self.not_assigned? && user.not_assigned?
			self.users << user
			assigment = assigments.last
			assigment.assigned_time = Time.now
			assigment.save!
			user.assign_cab!
			self.assign!
			self
		elsif self.assigned?
			self.errors.add(:base, "Cab already assigned")
			self
		else
			self.errors.add(:base, "User already assigned")
			self
		end
	end

	def start_ride(latitude, longitude)
		if assigned?
			assigment = assigments.last
			assigment.start_ride(latitude, longitude)
			start_ride!
		else
			self.errors.add(:base, "Cab is not assigned")
			self
		end
	end

	def end_ride(latitude,longitude)
		if ride_started?
			assigment = assigments.last
			assigment.end_ride(latitude,longitude)
			end_ride!
			assigment.user.end_ride!
		else
			self.errors.add(:base, "Ride is not started yet")
			self
		end
	end

	def cancel_ride(latitude,longitude)
		if assigned?
			assigment = assigments.last
			assigment.cancel_ride
			self.cancel_ride!
			assigment.user.end_ride!
		else
			self.errors.add(:base, "Cab is not assigned")
			self
		end
	end

	def get_location
		[current_latitude,current_longitude]
	end	

	def set_location(lat,long)
		current_latitude = lat.to_f
		current_longitude = long.to_f
		self.save!
	end

	def current_cab_user
		assigned? ? users.last : (ride_started? ? users.last : nil)
	end
end
