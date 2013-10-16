require 'dockingstation'

describe DockingStation do

	let(:bike) {Bike.new}
	let(:station) {DockingStation.new(:capacity => 20)}

	def fill_station(station)
		20.times {station.dock(Bike.new)}
	end


	it 'should accept a bike' do
		expect(station.bike_count).to eq 0
		station.dock(bike)
		expect(station.bike_count).to eq 1
	end

	it 'should release a bike' do
		station.dock bike
		station.release bike
		expect(station.bike_count).to eq 0
	end

	it 'knows when it is full' do
		expect(station).not_to be_full
		fill_station station
		expect(station).to be_full
	end

	it 'knows when it is empty' do
		expect(station).to be_empty
	end

	it 'should not accept a bike if it is full' do
		fill_station station
		expect(lambda {station.dock(bike)}).to raise_error(RuntimeError)
	end

	it 'should not release a bike if it is empty' do
		expect(lambda {station.release(bike)}).to raise_error(RuntimeError)
	end

	it 'should provide the list of available bikes' do
		working_bike, broken_bike = Bike.new, Bike.new
		broken_bike.break!
		station.dock(working_bike)
		station.dock(broken_bike)
		expect(station.available_bikes).to eq([working_bike])
	end

	it 'should provide the list of broken bikes' do
		working_bike, broken_bike = Bike.new, Bike.new
		broken_bike.break!
		station.dock(working_bike)
		station.dock(broken_bike)
		expect(station.broken_bikes).to eq([broken_bike])
	end

	it 'can release a broken bike' do
		working_bike, broken_bike = Bike.new, Bike.new
		broken_bike.break!
		station.dock(working_bike)
		station.dock(broken_bike)
		station.release_broken_bike
		expect(station.bike_count).to eq 1
		expect(station.available_bikes).to eq([working_bike])
	end

	it 'releases only available bikes to person' do
		working_bike, broken_bike = Bike.new, Bike.new
		broken_bike.break!
		station.dock(working_bike)
		station.dock(broken_bike)
		station.release_available_bikes
		expect(station.bike_count).to eq 1
		expect(station.broken_bikes).to eq([broken_bike])
	end

	it 'does not release broken bikes to person' do

	end

end



