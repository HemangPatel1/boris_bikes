require 'person'

describe Person do
	it 'has no bike' do
		person = Person.new
		expect(person).not_to have_bike
	end

	it 'has a bike' do
		person = Person.new :bike
		expect(person).to have_bike
	end

	it 'should be able to rent a bike from station' do
		person = Person.new
		station = double :station
		expect(station).to receive(:issue_bike)

		person.rent_bike_from station
	end

	it 'should be have a bike after renting it from the station' do
		person = Person.new
		station = double :station, {:issue_bike => :bike}
		person.rent_bike_from station
		expect(person).to have_bike
	end

	it 'should be able to return bike to station' do
		person = Person.new :bike
		station = double :station
		expect(station).to receive(:dock)

		person.return_bike_to station
	end

	it 'has no bike after returning bike to station' do
		person = Person.new :dock
		station = double :station, {:dock => nil}
		person.return_bike_to station
		expect(person).not_to have_bike
	end

	it 'can break a bike' do
		person = Person.new :bike
		bike = double :bike
		expect(bike).to receive(:break!)

		person.breaks_bike(bike)
	end


end
