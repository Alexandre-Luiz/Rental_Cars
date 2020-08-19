require 'rails_helper'

feature 'Admin register car model' do
  scenario 'successfully register car model' do
    #arrenge
    CarCategory.create!(name: 'Top', 
                        daily_rate: '20', car_insurance: '30', 
                        third_party_insurance: '40')

      # Não precisa cadastrar modelo porque só preciso da categoria 

    #act
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
    # Veja que eu por ter criado o prompt, não preciso mandar o capybara selecionar 'nada' na categoria
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