require 'rails_helper'

describe 'Admin creates user' do
  it 'successfully' do
    warehouse = create(:warehouse, name: 'Galpão Santa Maria')
    admin = build(:user, role: 'admin')
    login_as admin, scope: :admin
    
    visit users_path
    click_on 'Criar novo usuário'

    fill_in 'Nome', with: 'Fulano'
    fill_in 'Email', with: 'fulano@mercadores.com.br'
    fill_in 'CPF', with: CPF.generate
    fill_in 'Matrícula', with: '012345'
    select 'Galpão Santa Maria', from: 'Galpão de origem'

    expect { click_on 'Criar Usuário' }.to change { User.count }.by(1)
    expect(page).to have_text('Usuário criado com sucesso')
    expect(current_path).to eq(users_path)
  end

  xit 'cannot create if role dif from admin' do
  end
end