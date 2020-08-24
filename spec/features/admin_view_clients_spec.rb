require 'rails_helper'
feature 'Admin view car categories' do
  scenario 'must be logged in' do
    
    visit root_path
    click_on 'Clientes'

    expect(current_path).to eq(new_user_session_path)
  end

end