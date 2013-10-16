class Person


	def initialize bike=nil
		@bike = bike
	end

	def has_bike?
		@bike
	end

	def rent_bike_from station
		@bike = station.release_available_bike
	end

	def return_bike_to station
		@bike = station.dock @bike
	end

	def breaks_bike bike
		bike.break!
	end

end
