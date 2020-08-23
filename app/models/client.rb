class Client < ApplicationRecord
  validates :name, :cpf, :email,
            presence: true

  def client_information
    "#{name} - #{cpf}"
  end
end
