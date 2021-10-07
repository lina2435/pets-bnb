class User < ApplicationRecord
  has_many :bookings
  has_many :flats
  has_many :bookings_as_owner, through: :flats, source: :bookings
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, :last_name, presence: true
end
