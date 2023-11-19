class Room < ApplicationRecord
  validates :name, :description, :dimension, :capacity, :price, presence: true
  enum status: { full: 0, vacant: 2 }
  belongs_to :inn
  has_many :adjusted_price
  has_many :reservation
end
