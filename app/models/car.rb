class Car < ApplicationRecord
  belongs_to :car_model

  validates :license_plate, :color, presence: true
  
  enum status: { available: 0, rented: 10 }
end
