class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :car_category
  belongs_to :user

  def ticket_calculation
    rental_period = end_date-start_date
    ticket = rental_period * (car_category.daily_rate + 
                              car_category.car_insurance + 
                              car_category.third_party_insurance)
  end
end
