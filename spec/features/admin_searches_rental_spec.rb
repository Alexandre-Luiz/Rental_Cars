require 'rails_helper'

feature 'Admin searches rental' do
  scenario 'and exact match' do
    client = Client.create!(name: 'Sicrano', email: 'sicrano@test.com', cpf: '685.598.270-05')
    car_category = CarCategory.create!(name: 'A', daily_rate: '10', car_insurance: '10', third_party_insurance: '10')
    user = User.create!(name: 'Alexandre Elias', 
                          email: 'alexandre@email.com', 
                          password: '123456789')
    rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now,
                          client: client, car_category: car_category ,user: user)
    another_rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now,
                          client: client, car_category: car_category ,user: user)
                      

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Busca de locação', with: rental.token
    click_on 'Buscar'

    expect(page).to have_content(rental.token)
    # Apesar de ser identico ao rental, o token sempre vai ser único
    expect(page).not_to have_content(another_rental.token)
    expect(page).to have_content(rental.client.name)
    expect(page).to have_content(rental.client.cpf)
    expect(page).to have_content(rental.client.email)
    expect(page).to have_content(rental.car_category.name)
    expect(page).to have_content(rental.user.email)

  end
end