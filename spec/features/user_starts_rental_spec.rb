require 'rails_helper'

feature 'User starts a rental for a client' do

  # Terminar - Video aula 11 (desde o começo)
  scenario 'successfully' do
    client = Client.create!(name: 'Sicrano', email: 'sicrano@test.com', cpf: '685.598.270-05')
    car_category = CarCategory.create!(name: 'A', daily_rate: '10', car_insurance: '10', third_party_insurance: '10')
    car_model = CarModel.create!(name: 'Ka', year: 2019, 
                                 manufacturer: 'Ford', motorization: '1.0', 
                                 car_category: car_category , fuel_type: 'Flex')
    user = User.create!(name: 'Alexandre Elias', email: 'alexandre@email.com', 
                        password: '123456789')
    rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now,
                          client: client, car_category: car_category ,user: user)
    car = Car.create!(license_plate: 'ABC123', color: 'Vermelho', 
                      car_model: car_model,
                      mileage: 0)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Busca de locação', with: rental.token
    click_on 'Buscar'
    click_on 'Ver detalhes'
    click_on 'Iniciar locação'
    select "#{car_model.name} - #{car.color} #{car.license_plate}", from: 'Carros disponíveis'
    click_on 'Iniciar'

    expect(page).to have_content('Locação iniciada com sucesso')
    expect(page).to have_content(car.license_plate)
    expect(page).to have_content(car.color)
    expect(page).to have_content(car_category.name)
    expect(page).to have_content(user.email)
    expect(page).to have_content(client.name)
    expect(page).to have_content(client.email)
    expect(page).to have_content(client.cpf)
  end
end