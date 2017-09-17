require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def test_assigned_cab
  	user = users(:one)
  	cab = cabs(:one)
  	cab.cab_assign(user)
  	assert user.assigned_cab == cab
  end

  def test_assigned_cab_when_multiple_assigment_done
  	user = users(:one)
  	cab = cabs(:one)
  	cab.cab_assign(user)
  	user1 = users(:two)
  	cab1 = cabs(:two)
  	cab1.cab_assign(user1)
  	assert user.assigned_cab == cab
  end

  def test_unassigned_cab
  	user = users(:one)
  	assert user.assigned_cab == nil
  end

  def test_after_start_ride
  	user = users(:one)
  	cab = cabs(:one)
  	cab.cab_assign(user)
  	cab.start_ride(12.03, 11.00)
  	assert user.assigned_cab == cab
  end

  def test_after_end_ride
  	user = users(:one)
  	cab = cabs(:one)
  	cab.cab_assign(user)
  	cab.start_ride(12.03, 11.00)
  	cab.end_ride(12.03, 11.00)
  	user.reload
  	assert user.assigned_cab == nil
  end

end
