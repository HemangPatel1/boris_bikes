class DockingStation
	DEFAULT_CAPACITY = 10

	def initialize(options = {})
		@capacity = options.fetch(:capacity || DEFAULT_CAPACITY)
		@bikes = []
	end

	def bike_count
		@bikes.count
	end

	def dock bike
		raise "Station is full" if full?
		@bikes << bike
	end

	def release bike
		raise "Station is empty" if empty?
		@bikes.delete bike
	end

	def full?
		bike_count == @capacity
	end

	def empty?
		bike_count == 0
	end

	def available_bikes
		@bikes.reject {|bike| bike.broken?}
	end

	def broken_bikes
		@bikes.select {|bike| bike.broken?}
	end

	def release_broken_bike
		@bikes.delete_if {|bike| bike.broken?}
	end
end
