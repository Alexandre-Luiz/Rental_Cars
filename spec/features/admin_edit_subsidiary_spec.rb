require 'rails_helper'

feature 'Admin edit subsidiary' do
  scenario 'successfully' do
    #arrenge
    RentalSubsidiary.create!(name:'Campinas', 
                             cnpj:'82.190.506/0001-75', 
                             adress: 'Av. Taquaral, 1000' )
    #act
    visit root_path
    click_on 'Subsidiárias'
    click_on 'Campinas'
    click_on 'Editar'
    fill_in 'Nome', with: 'Mato Grosso'
    fill_in 'CNPJ', with: '41.724.771/0001-09'
    fill_in 'Endereço', with: 'Rua do matão, 10'
    click_on 'Enviar'

    #assert
    expect(page).to have_content('Mato Grosso')
    expect(page).to have_content('41.724.771/0001-09')
    expect(page).to have_content('Rua do matão, 10')
  end

  scenario 'can not be blank' do
    # Validação dos campos para edição tem q preencher alguma
    # coisa e retornar mensagem pro usuário
  end

  scenario 'cnpj should be valid' do
    #Tem que ver o de validação de CNPJ com a gem
  end
end