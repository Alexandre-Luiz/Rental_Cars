class CarCategory < ApplicationRecord
  
  has_many :car_models
  
  # Validações de presença (campo em branco)
  validates :name, 
            :daily_rate, 
            :car_insurance, 
            :third_party_insurance, 
            presence: {message: 'não pode ficar em branco'}

  # Validação de registro único
  validates :name,
            uniqueness: {message: 'já está em uso', 
                         case_sensitive: false}
end
