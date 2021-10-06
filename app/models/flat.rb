class Flat < ApplicationRecord
  has_many :bookings
  belongs_to :user, optional:true
  validates :address, :description, :price_per_night, :number_of_pets, :title, presence: true
  has_many_attached :photos
end
