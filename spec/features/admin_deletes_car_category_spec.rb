require 'rails_helper'

feature 'Admin deletes category' do
  
  scenario 'must be signed in' do
    visit root_path
    click_on 'Categorias'

    #Quando clico e não estiver logado, deve me jogar para página de login
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  scenario 'successfully' do
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                      third_party_insurance: 10.5)

    user = User.create!(name: 'Alexandre Elias', 
                        email: 'alexandre@email.com', 
                        password: '123456789')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Categorias'
    click_on 'Top'
    click_on 'Apagar'

    expect(current_path).to eq car_categories_path
    expect(page).to have_content('Nenhuma categoria cadastrada')
  end

  scenario 'and keep anothers' do
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
    click_on 'Apagar'

    expect(current_path).to eq car_categories_path
    expect(page).not_to have_content('Top')
    expect(page).to have_content('Flex')
  end
end
