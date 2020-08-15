class RentalSubsidiary < ApplicationRecord
  validates :name, 
            :cnpj, 
            :adress, 
            presence: {message: 'não pode ficar em branco'}
            
end
