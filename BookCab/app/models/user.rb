class User < ApplicationRecord
  include AASM
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  before_save :assign_role
  has_many :assigments
  has_many :cabs, :through => :assigments
  aasm do
    state :not_assigned, :initial=>true
    state :assigned
    event :assign_cab do
      transitions :from => :not_assigned, :to => :assigned
    end
    event :end_ride do
      transitions :from => :assigned, :to => :not_assigned
    end
  end

  def get_current_location
    [current_lat, current_long]
  end

  def set_current_location(latitude,longitude)
    current_lat = latitude
    current_long = longitude
    self.save!
  end

  def admin?
  	role=="admin"
  end

  def customer?
  	role=="customer"
  end

  def assigned_cab
    if assigned?
      cabs.last
    else
      nil
    end
  end

  private

  def assign_role
  	self.role="user"
  end
end
