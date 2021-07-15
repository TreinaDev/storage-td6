require 'rails_helper'

describe 'Admin creates user' do
  it 'successfully' do
    warehouse = create(:warehouse, name: 'Galpão Santa Maria')
    admin = create(:user, role: 'admin')
    create(:user, name: 'Fulano', registration_code: '123457', email: 'fulano@mercadores.com.br', warehouse: warehouse)
    create(:user, name: 'Ciclano', registration_code: '012345', email: 'ciclano@mercadores.com.br', warehouse: warehouse)
    login_as admin

    visit users_path

    expect(page).to have_text('Fulano')
    expect(page).to have_text('Ciclano')
    expect(page).to have_text('123457')
    expect(page).to have_text('012345')
    expect(page).to have_text('Galpão Santa Maria', count: 2)
    expect(page).to have_text('Sem galpão')
  end
end