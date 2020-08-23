require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'must be logged in' do
    visit root_path
    click_on 'Subsidiárias'

    expect(current_path).to eq new_user_session_path
  end
  
  scenario 'Must be logged in to create a new subsidiary' do
    
    visit new_rental_subsidiary_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'successfully' do
    user = User.create!(name: 'Alexandre Elias', 
                        email: 'alexandre@email.com', 
                        password: '123456789')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Subsidiárias'
    click_on 'Registrar nova subsidiária'

    fill_in 'Nome', with: 'Campinas'
    fill_in 'CNPJ', with: '41.635.098/0001-30'
    fill_in 'Endereço', with: 'Av. Taquaral'
    click_on 'Enviar'

    expect(current_path).to eq rental_subsidiary_path(RentalSubsidiary.last)
    expect(page).to have_content('Campinas')
    expect(page).to have_content('41.635.098/0001-30')
    expect(page).to have_content('Av. Taquaral')
  end

  scenario 'must fill in all fields' do
    user = User.create!(name: 'Alexandre Elias', 
                        email: 'alexandre@email.com', 
                        password: '123456789')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Subsidiárias'
    click_on 'Registrar nova subsidiária'
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('CNPJ não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
  end

  scenario 'CNPJ must be valid' do
    user = User.create!(name: 'Alexandre Elias', 
                        email: 'alexandre@email.com', 
                        password: '123456789')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Subsidiárias'
    click_on 'Registrar nova subsidiária'
    fill_in 'CNPJ', with: '32.435.435/0012-00'
    click_on 'Enviar'

    expect(page).to have_content('CNPJ inválido')
  end

  scenario 'CNPJ must be unique' do
    user = User.create!(name: 'Alexandre Elias', 
                        email: 'alexandre@email.com', 
                        password: '123456789')

    login_as(user, scope: :user)

    visit root_path
    click_on 'Subsidiárias'
    click_on 'Registrar nova subsidiária'
    fill_in 'Nome', with: 'Campinas'
    fill_in 'CNPJ', with: '50.642.295/0001-78'
    fill_in 'Endereço', with: 'Av. ribeirinha'
    click_on 'Enviar'

    visit root_path
    click_on 'Subsidiárias'
    click_on 'Registrar nova subsidiária'
    fill_in 'Nome', with: 'Sergipe'
    fill_in 'CNPJ', with: '50.642.295/0001-78'
    fill_in 'Endereço', with: 'Av. ribeirinha'
    click_on 'Enviar'
    
    expect(page).to have_content('CNPJ já cadastrado')
  end
end