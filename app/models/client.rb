class Client < ApplicationRecord
  validates :name, :cpf, :email,
            presence: true
end
