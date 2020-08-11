require 'rails_helper'

feature 'Admin view subsidiaries' do
  scenario 'successfully' do
    RentalSubsidiary.create!(name:'São Paulo', 
                             cnpj:'71.734.693/0001-94', 
                             adress:'Av. Paulista')
    RentalSubsidiary.create!(name:'Recife', 
                             cnpj:'52.536.790/0001-28', 
                             adress:'Av. Conde de Boa Vista')

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

    visit root_path
    click_on 'Subsidiárias'
    click_on 'São Paulo'

    expect(page).to have_content('São Paulo')
    expect(page).to have_content('71.734.693/0001-94')
    expect(page).to have_content('Av. Paulista')
    expect(page).not_to have_content('Recife')
  end

end