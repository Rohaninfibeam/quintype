require 'test_helper'

class CabTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  #test to find neaby cab
  def test_find_nearby_cab
  	minicab = cabs(:one)
  	lat = minicab.current_latitude
  	long = minicab.current_longitude
  	assert Cab.find_near_by_cabs(lat,long).id == minicab.id
  end

  #test for finding nearby cab when 
  def test_find_nearby_cab_when_one_is_assigned
  	minicab = cabs(:one)
  	lat = minicab.current_latitude
  	long = minicab.current_longitude
  	minicab.assign!
  	assert_not Cab.find_near_by_cabs(lat,long).id == minicab.id
  end

  #find nearby cab when all cabs are assigned it should return nil
  def test_find_nearby_cab_when_all_assigned
  	minicab = cabs(:one)
  	lat = minicab.current_latitude
  	long = minicab.current_longitude
  	minicab.assign!
  	cabs(:two).assign!
  	cabs(:three).assign!
  	assert_not Cab.find_near_by_cabs(lat,long).present?
  end

  def test_assign_unassigned_cab
  	cab = cabs(:one)
  	user = users(:one)
  	cab = cab.cab_assign(user)
  	assert cab.errors.messages[:base].length == 0 
  end

  def test_assign_assigned_cab
  	cab = cabs(:one)
  	user = users(:one)
  	cab.assign!
  	cab = cab.cab_assign(user)
  	assert cab.errors.messages[:base].length == 1 && cab.errors.messages[:base][0] == "Cab already assigned"
  end

  def test_assign_assigned_user
  	cab = cabs(:one)
  	user = users(:one)
  	user.assign_cab!
  	cab = cab.cab_assign(user)
  	assert cab.errors.messages[:base].length == 1 && cab.errors.messages[:base][0] == "User already assigned"
  end

  def test_start_ride
  	cab = cabs(:one)
  	user = users(:one)
  	cab = cab.cab_assign(user)
  	assert cab.start_ride(11.23, 34.45)
  end

  def test_start_ride_not_asigned
  	cab = cabs(:one)
  	cab = cab.start_ride(12.03, 11.00)
  	assert cab.errors.messages[:base].length == 1 && cab.errors.messages[:base][0] == "Cab is not assigned"
  end

  def test_end_ride
  	cab = cabs(:one)
  	user = users(:one)
  	cab.cab_assign(user)
  	c = cab.end_ride(12.00, 13.21)
  	assert c.errors.messages[:base].length == 1 && cab.errors.messages[:base][0] == "Ride is not started yet"
  end

  def test_end_ride_succes
  	cab = cabs(:one)
  	user = users(:one)
  	cab.cab_assign(user)
  	cab.start_ride(12.03, 11.00)
  	assert cab.end_ride(12.00, 13.21)
  end

  def test_cancel_ride
  	cab = cabs(:one)
  	user = users(:one)
  	cab.cab_assign(user)
  	assert cab.cancel_ride(12.00, 13.21)
  end

end
