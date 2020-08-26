class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :car_category
  belongs_to :user

  # Callbacks
  before_create :generate_token

  def ticket_calculation
    rental_period = end_date-start_date
    ticket = rental_period * (car_category.daily_rate + 
                              car_category.car_insurance + 
                              car_category.third_party_insurance)
  end

  private

  def generate_token
    # Aqui tenho que usar self porque é o método setter e não uma criação de variável nova. Para fazer
    # essa diferenciação, preciso utilizar o self
    # Isso acontece especificamente no caso de atribuições ( = )
    self.token = SecureRandom.alphanumeric(6).upcase
  end
end
