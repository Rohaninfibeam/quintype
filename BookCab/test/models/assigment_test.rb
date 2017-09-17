require 'test_helper'

class AssigmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def test_start_test
  	cab = cabs(:one)
  	user = users(:one)
  	cab = cab.cab_assign(user)
  	cab.start_ride(11.23, 34.45)
  	cab.reload
  	assigment = cab.assigments.last
  	assert assigment.start_time != nil && assigment.source_lat == 11.23 && assigment.source_long == 34.45
  end

  def test_get_lat_long_source
  	cab = cabs(:one)
  	user = users(:one)
  	cab = cab.cab_assign(user)
  	assigment = cab.assigments.last
  	assigment.set_source_location(11.23, 34.45)
  	assigment.reload
  	assert assigment.get_source_location == [11.23 , 34.45]
  end

  def test_get_lat_long_destination
  	cab = cabs(:one)
  	user = users(:one)
  	cab = cab.cab_assign(user)
  	assigment = cab.assigments.last
  	assigment.set_dest_location(11.22, 14.45)
  	assigment.reload
  	assert assigment.get_dest_location == [11.22, 14.45]
  end

  def test_end_ride
  	cab = cabs(:one)
  	user = users(:one)
  	cab = cab.cab_assign(user)
  	cab.start_ride(11.23, 34.45)
  	cab.end_ride(11.53, 14.45)
  	debugger
  	assigment = cab.assigments.last
  	assert assigment.end_time != nil && assigment.dest_lat == 11.53 && assigment.dest_long == 14.45 && assigment.distance && assigment.price
  end

end
