class User < ApplicationRecord
  before_create :set_default_avatar
  has_many :bookings
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, :last_name, presence: true
  has_one_attached :avatar
  def set_default_avatar
    # your code
  end
end
