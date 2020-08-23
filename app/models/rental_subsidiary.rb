class RentalSubsidiary < ApplicationRecord
  validates :name, 
            :cnpj, 
            :adress, 
            presence: true
  
  validates :cnpj, uniqueness: {message: 'já cadastrado'}
  validate :cnpj_validation

  def cnpj_validation
    if cnpj.present? && !CNPJ.valid?(cnpj)
      errors.add(:cnpj, 'inválido')
    end
  end
end
