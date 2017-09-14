class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  before_save :assign_role

  def admin?
  	role=="admin"
  end

  def driver?
  	role=="driver"
  end

  def customer?
  	role=="customer"
  end

  private

  def assign_role
  	debugger
  	self.role="user"
  end
end
