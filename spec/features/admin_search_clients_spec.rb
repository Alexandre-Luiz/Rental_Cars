require 'rails_helper'

feature 'Admin searches clients' do
  scenario 'by name successfully' do
    user = User.create!(name: 'Alexandre Elias', 
                        email: 'alexandre@email.com', 
                        password: '123456789')
    Client.create!(name:'Beltrano', cpf:'201.991.270-85', email:'beltrano@email.com')
    Client.create!(name:'Pedroso',cpf:'105.618.130-35', email:'pedroso@email.com')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Clientes'
    fill_in 'Busca', with: 'Beltrano'
    click_on 'Pesquisar'

    expect(page).to have_content('Resultados da pesquisa')
    expect(page).to have_content('Beltrano')
    expect(page).to have_content('201.991.270-85')
    expect(page).to have_content('beltrano@email.com')
    expect(page).not_to have_content('Pedroso')
    expect(page).not_to have_content('105.618.130-35')
    expect(page).not_to have_content('pedroso@email.com')
  end
end