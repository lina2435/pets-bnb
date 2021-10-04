class User < ApplicationRecord
  has_many :bookings
  validates :first_name, :last_name, :email, :address, :pet_name, presence: true
end
