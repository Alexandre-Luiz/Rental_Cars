class Client < ApplicationRecord
  validates :name, :cpf, :email,
            presence: true
  
  validates :cpf, uniqueness: {message: 'já cadastrado', 
                              case_sensitive: false}
  validate :cpf_validation

  def client_information
    "#{name} - #{cpf}"
  end

  private

  def cpf_validation
    # Vou fazer guard clause aqui e da maneira mais comum no CNPJ da subsidiary
    return if cpf.blank?
    return if CPF.valid?(cpf)
    
    errors.add(:cpf, :invalid) #Estou chamando a msg do i18n
  end
end
