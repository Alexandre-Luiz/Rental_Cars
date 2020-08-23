require 'rails_helper'

feature 'Admin view subsidiaries' do
  scenario 'musb be logged in' do
    visit root_path
    click_on 'Subsidiárias'

    expect(current_path).to eq new_user_session_path
  end
  
  scenario 'successfully' do
    RentalSubsidiary.create!(name:'São Paulo', 
                             cnpj:'71.734.693/0001-94', 
                             adress:'Av. Paulista')
    RentalSubsidiary.create!(name:'Recife', 
                             cnpj:'52.536.790/0001-28', 
                             adress:'Av. Conde de Boa Vista')
    user = User.create!(name: 'Alexandre Elias', 
                        email: 'alexandre@email.com', 
                        password: '123456789')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Subsidiárias'

    expect(page).to have_content('São Paulo')
    expect(page).to have_content('Recife')
  end

  scenario 'and view details' do
    RentalSubsidiary.create!(name:'São Paulo', 
                             cnpj:'71.734.693/0001-94', 
                             adress:'Av. Paulista')
    RentalSubsidiary.create!(name:'Recife', 
                             cnpj:'52.536.790/0001-28', 
                             adress:'Av. Conde de Boa Vista')
    user = User.create!(name: 'Alexandre Elias', 
                        email: 'alexandre@email.com', 
                        password: '123456789')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Subsidiárias'
    click_on 'São Paulo'

    expect(page).to have_content('São Paulo')
    expect(page).to have_content('71.734.693/0001-94')
    expect(page).to have_content('Av. Paulista')
    expect(page).not_to have_content('Recife')
  end

  scenario 'must be logged in to see details of subsidiary' do
    subsidiary = RentalSubsidiary.create!(name:'São Paulo', 
                             cnpj:'71.734.693/0001-94', 
                             adress:'Av. Paulista')
                            
    visit rental_subsidiary_path(subsidiary)

    expect(current_path).to eq new_user_session_path
  end
end