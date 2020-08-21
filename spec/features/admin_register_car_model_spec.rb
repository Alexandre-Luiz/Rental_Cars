require 'rails_helper'

feature 'Admin register car model' do
  scenario 'must be logged in' do
    visit root_path
    click_on 'Modelos de carro' 
    expect(current_path).to eq new_user_session_path
  end
  
  scenario 'successfully register car model' do
    #arrenge
      # Não precisa cadastrar modelo porque só preciso da categoria 
    CarCategory.create!(name: 'Top', 
                        daily_rate: '20', car_insurance: '30', 
                        third_party_insurance: '40')
    user = User.create!(name: 'Alexandre Elias', 
                        email: 'alexandre@email.com', 
                        password: '123456789')
      
    #act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de carro'
    click_on 'Cadastrar novo modelo de carro'
    fill_in 'Nome', with: 'Ka'
    fill_in 'Ano', with: '2020'
    fill_in 'Fabricante', with: 'Ford'
    fill_in 'Potência', with: '1.0'
    select 'Top', from: 'Categoria de carro'
    fill_in 'Combustível', with: 'Flex'
    click_on 'Enviar'

    #assert
    expect(page).to have_content('Ka')
    expect(page).to have_content('2020')
    expect(page).to have_content('Ford')
    expect(page).to have_content('1.0')
    expect(page).to have_content('Top')
    expect(page).to have_content('Flex')
  end

  scenario 'must fill in all fields' do
    user = User.create!(name: 'Alexandre Elias', 
                        email: 'alexandre@email.com', 
                        password: '123456789')
    
    # Veja que eu por ter criado o prompt, não preciso mandar o capybara selecionar 'nada' na categoria
    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de carro'
    click_on 'Cadastrar novo modelo de carro'
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Ano não pode ficar em branco')
    expect(page).to have_content('Fabricante não pode ficar em branco')
    expect(page).to have_content('Potência não pode ficar em branco')
    # Erro da categoria, por sem um objeto relacionado a outro, vem do belongs_to
    expect(page).to have_content('Categoria de carro é obrigatório(a)')
    expect(page).to have_content('Combustível não pode ficar em branco')

  end 
end