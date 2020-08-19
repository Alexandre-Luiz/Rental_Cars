class CarModel < ApplicationRecord
  belongs_to :car_category

  # car_category já é obrigatório por causa do belongs_to
  validates :name, :year, 
            :manufacturer, :motorization, 
            :fuel_type, 
            presence: true
end
