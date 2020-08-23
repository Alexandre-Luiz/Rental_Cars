require 'rails_helper'

feature 'Admin register a client' do
  scenario 'must be logged to register a client' do
    
    visit root_path
    click_on 'Cadastrar cliente'

    expect(current_path).to eq new_user_session_path
  end

  scenario 'must be logged in to see the register form' do
    
    visit new_client_path

    expect(current_path).to eq new_user_session_path
  end
  
  scenario 'successfully' do
    Client.create!(name: 'Rafael', cpf: '443.004.310-86', email: 'rafael@email.com')
    user = User.create!(name: 'Alexandre Elias', 
                        email: 'alexandre@email.com', 
                        password: '123456789')
    
    #act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Cadastrar cliente'
    fill_in 'Nome', with: 'Rafael'
    fill_in 'CPF', with: '443.004.310-86'
    fill_in 'Email', with: 'rafael@email.com'
    click_on 'Cadastrar'

    expect(current_path).to eq client_path(Client.last.id)
    expect(page).to have_content('Rafael')
    expect(page).to have_content('443.004.310-86')
    expect(page).to have_content('rafael@email.com')
  end

  scenario 'must fill all fields' do
    Client.create!(name: 'Rafael', cpf: '443.004.310-86', email: 'rafael@email.com')
    user = User.create!(name: 'Alexandre Elias', 
                        email: 'alexandre@email.com', 
                        password: '123456789')
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Cadastrar cliente'
    click_on 'Cadastrar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('CPF não pode ficar em branco')
    expect(page).to have_content('Email não pode ficar em branco')
  end

  scenario 'and CPF must be valid' do
    user = User.create!(name: 'Alexandre Elias', 
                        email: 'alexandre@email.com', 
                        password: '123456789')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Cadastrar cliente'
    fill_in 'CPF', with: '111.111.111-99'
    click_on 'Cadastrar'

    expect(page).to have_content('CPF não é válido')
  end

  scenario 'and CPF must be unique' do
    user = User.create!(name: 'Alexandre Elias', 
                        email: 'alexandre@email.com', 
                        password: '123456789')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Cadastrar cliente'
    fill_in 'Nome', with: 'Rafael'
    fill_in 'CPF', with: '156.440.570-20'
    fill_in 'Email', with: 'rafael@email.com'
    click_on 'Cadastrar'
    
    visit root_path
    click_on 'Cadastrar cliente'
    fill_in 'CPF', with: '156.440.570-20'
    click_on 'Cadastrar'

    expect(page).to have_content('CPF já cadastrado')
  end

end