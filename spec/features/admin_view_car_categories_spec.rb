require 'rails_helper'

feature 'Admin view car categories' do
  scenario 'must be logged in' do
    
    visit root_path
    click_on 'Categorias'

    expect(current_path).to eq(new_user_session_path)
  end
  
  scenario 'successfully' do
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)
    CarCategory.create!(name: 'Flex', daily_rate: 80, car_insurance: 8.5,
                        third_party_insurance: 8.5)
                      
    user = User.create!(name: 'Alexandre Elias', 
                        email: 'alexandre@email.com', 
                        password: '123456789')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Categorias'

    expect(page).to have_content('Top')
    expect(page).to have_content('Flex')
  end

  scenario 'and view details' do
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)
    CarCategory.create!(name: 'Flex', daily_rate: 80, car_insurance: 8.5,
                        third_party_insurance: 8.5)

    user = User.create!(name: 'Alexandre Elias', 
                        email: 'alexandre@email.com', 
                        password: '123456789')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Categorias'
    click_on 'Top'

    expect(page).to have_content('Top')
    expect(page).to have_content('R$ 105,50')
    expect(page).to have_content('R$ 58,50')
    expect(page).to have_content('R$ 10,50')
    expect(page).not_to have_content('Flex')
  end

  scenario 'but must be logged in to view details' do
    top = CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                                  third_party_insurance: 10.5)
    
    visit car_category_path(top)

    expect(current_path).to eq new_user_session_path
  end
  scenario 'and no car categories are created' do
    user = User.create!(name: 'Alexandre Elias', 
                        email: 'alexandre@email.com', 
                        password: '123456789')
    login_as(user, scope: :user)
    
    visit root_path
    click_on 'Categorias'

    expect(page).to have_content('Nenhuma categoria cadastrada')
  end

  scenario 'and view all car models under that category' do
    # Arrenge
    car_category = CarCategory.create!(name: 'Basic', daily_rate: 20, 
                                       car_insurance: 50, third_party_insurance: 100 )
    CarModel.create!(name: 'Ka', year: 2019, 
                     manufacturer: 'Ford', motorization: '1.0', 
                     car_category: car_category , fuel_type: 'Flex')
    CarModel.create!(name: 'Gol', year: 2020, 
                     manufacturer: 'Volkswagen', motorization: '1.0', 
                     car_category: car_category, fuel_type: 'Gasolina')
    user = User.create!(name: 'Alexandre Elias', 
                        email: 'alexandre@email.com', 
                        password: '123456789')
    
    #Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias'
    click_on 'Basic'

    #Assert
    expect(page).to have_content('Basic')
    expect(page).to have_content('20')
    expect(page).to have_content('50')
    expect(page).to have_content('100')
    expect(page).to have_content('Ka')
    expect(page).to have_content('Gol')
    expect(page).to have_content('Lista de modelos da categoria Basic')

  end

  scenario 'and return to home page' do
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)
                      
    user = User.create!(name: 'Alexandre Elias', 
                        email: 'alexandre@email.com', 
                        password: '123456789')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Categorias'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and return to manufacturers page' do
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)

    user = User.create!(name: 'Alexandre Elias', 
                        email: 'alexandre@email.com', 
                        password: '123456789')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Categorias'
    click_on 'Top'
    click_on 'Voltar'

    expect(current_path).to eq car_categories_path
  end
end
