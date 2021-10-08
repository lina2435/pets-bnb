class Flat < ApplicationRecord
  has_many :bookings
  belongs_to :user
  validates :address, :description, :price_per_night, :number_of_pets, :title, presence: true
  has_many_attached :photos

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
