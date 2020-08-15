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
    #expect(page).to not_have('Flex')
    #expect(page).to not_have('Gasolina')
    #expect(page).to not_have('1.0')
  end
end