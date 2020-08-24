require 'rails_helper'

feature 'Admin schedules a rental' do
  scenario 'successfully' do
    #Arrenge
    car_category = CarCategory.create!(name: 'Top', car_insurance: 100, daily_rate: 100, third_party_insurance: 100)
    client = Client.create!(name: 'Fulano', cpf: '525.463.580-06', email: 'test@client.com')
    user = User.create!(name: 'Alexandre Elias', email: 'alexandre@email.com', password: '123456789')

    #act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    click_on 'Agendar nova locação'
    fill_in 'Data de início', with: '21/08/2030'
    fill_in 'Data de término', with: '23/08/2030'
    select 'Fulano - 525.463.580-06', from: 'Cliente'
    select 'Top', from: 'Categoria de carro'
    click_on 'Agendar'

    expect(page).to have_content('21/08/2030')
    expect(page).to have_content('23/08/2030')
    expect(page).to have_content('Fulano')
    expect(page).to have_content('525.463.580-06')
    expect(page).to have_content('test@client.com')
    expect(page).to have_content('Top')
    expect(page).to have_content('R$ 600,00')
    expect(page).to have_content('Agendamento realizado com sucesso')
  end
  scenario 'must fill in all fields on scheduling' do
    visit root_path
    click_on 'Locações'
    click_on 'Agendar nova locação'
    click_on 'Agendar'
  end

  xscenario 'must be logged in to view rentals' do
  end
  xscenario 'must be logged in to schedule a rental' do
  end
end