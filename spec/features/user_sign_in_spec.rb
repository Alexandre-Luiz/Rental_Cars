require 'rails_helper'

feature 'User sign in' do
  # Testar que minha aplicação possibilita login (tela inicial > tela de login)
  scenario 'from home page' do
    #Arrenge
    
    #Act
    visit root_path
    
    #Assert
    expect(page).to have_link('Entrar', href: new_user_session_path)
  end

  # Faz login com sucesso
  scenario 'successfully login' do
    #Arrenge
    User.create!(name: 'Alexandre Elias', email: 'alexandre@email.com', password: '123456789')

    #Act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'alexandre@email.com'
    fill_in 'Senha', with: '123456789'
    click_on 'Entrar'

    #Assert
    expect(page).to have_content 'Alexandre Elias'
    expect(page).to have_content 'Login efetuado com sucesso'
    expect(page).to have_link 'Sair'
    expect(page).not_to have_link 'Entrar'
  end

  scenario 'and logout' do
    User.create!(name: 'Alexandre Elias', email: 'alexandre@email.com', password: '123456789')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'alexandre@email.com'
    fill_in 'Senha', with: '123456789'
    click_on 'Entrar'
    click_on 'Sair'

    expect(page).to have_content 'Logout efetuado com sucesso'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_content 'Alexandre Elias'
  end
end