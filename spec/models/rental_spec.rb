require 'rails_helper'

RSpec.describe Rental, type: :model do
  context 'token' do
    it 'token has to be created on create' do
      client = Client.create!(name: 'Sicrano', email: 'sicrano@test.com', cpf: '685.598.270-05')
      car_category = CarCategory.create!(name: 'A', daily_rate: '10', car_insurance: '10', third_party_insurance: '10')
      user = User.create!(name: 'Alexandre Elias', 
                          email: 'alexandre@email.com', 
                          password: '123456789')
      rental = Rental.new(start_date: Date.current, end_date: 1.day.from_now,
                          client: client, car_category: car_category ,user: user)

      rental.save!

      expect(rental.token).to be_present
      expect(rental.token.size).to eq(6)
      expect(rental.token).to match(/^[A-Z0-9]+$/)
    end
  end
end
