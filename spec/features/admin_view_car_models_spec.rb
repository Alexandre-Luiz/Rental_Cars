require 'rails_helper'

feature 'admin sees car models' do
  scenario 'and view list of car models registered' do
    #arrange
    car_category = CarCategory.create!(name: 'Basic', daily_rate: 20, 
                        car_insurance: 50, third_party_insurance: 100 )
    CarModel.create!(name: 'Ka', year: 2019, 
                     manufacturer: 'Ford', motorization: '1.0', 
                     car_category: car_category , fuel_type: 'Flex')
    CarModel.create!(name: 'Gol', year: 2020, 
                     manufacturer: 'Volkswagen', motorization: '1.0', 
                     car_category: car_category, fuel_type: 'Gasolina')
    
    #act
    visit root_path
    click_on 'Modelos de carro'

    #assert
    expect(page).to have_content('Ka')
    expect(page).to have_content('Ford')
    expect(page).to have_content('2019')
    expect(page).to have_content('Gol')
    expect(page).to have_content('Volkswagen')
    expect(page).to have_content('2020')
    expect(page).to have_link('Voltar', href: root_path)

  end

  scenario 'show details' do
    #arrange
    car_category = CarCategory.create!(name: 'Basic', daily_rate: 20, 
                                       car_insurance: 50, third_party_insurance: 100 )
    CarModel.create!(name: 'Ka', year: 2019, 
                     manufacturer: 'Ford', motorization: '1.0', 
                     car_category: car_category, fuel_type: 'Flex')
    
    #act
    visit root_path
    click_on 'Modelos de carro'
    click_on 'Ka'

    expect(page).to have_content('Ka')
    expect(page).to have_content('2019')
    expect(page).to have_content('Ford')
    expect(page).to have_content('1.0')
    expect(page).to have_content(car_category.name)
    expect(page).to have_content('Flex')

  end

  scenario 'nothing is registered' do
    visit root_path
    click_on 'Modelos de carro'

    expect(page).to have_content('Nenhum modelo de carro cadastrado')
  end
end